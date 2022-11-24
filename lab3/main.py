import pathlib
import json

class Network:
    def __init__(self, file_name_ids, file_name_connections):
        self.Items = self.ReadItems(file_name_ids)
        self.Connections = self.ReadConnections(file_name_connections)

    def ItemWithName(self, name):
        for item_id, item in self.Items.items():
                if item == name:
                    return item_id
        return None

    def ReadItems(self, json_file_name):
        items = {}
        with open(json_file_name, "r", encoding='utf-8') as read_entities:
            data = json.load(read_entities)
            for key, value in data.items():
                items[key] = value
        return items

    def ReadConnections(self, json_file_name):
        connections = []
        with open(json_file_name, "r", encoding='utf-8') as read_connections:
            data = json.load(read_connections)
            for item in data:
                connections += [item]
        return connections

    def ListConnectionsWith(self, user_input):
        if self.Items.get(user_input):
            item_id = user_input
        else:
            item_id = self.ItemWithName(user_input)

        if item_id == None:
            print("Items with this id or name doesn't exist")
            return

        for connection in self.Connections:
            if item_id == connection[0] or item_id == connection[2]:
                print("-", self.Items[connection[0]], connection[1], self.Items[connection[2]])

    def ListAll(self):
        for connection in self.Connections:
            print("-", self.Items[connection[0]], connection[1], self.Items[connection[2]])

folder = str(pathlib.Path(__file__).parent.resolve())
m = Network(folder+"/ids.json", folder+"/connections.json")

print('''\n
- Enter id of an item or its name to see connections with this item, 
- Leave input field blank to see the list of all connections, 
- Enter \'exit\' to leave the program''')

while True:
    user = input("\nEnter id or name: ")
    if user == "":
        m.ListAll()
    elif user == "exit":
        break
    else:
        print()
        m.ListConnectionsWith(user)

print("\nEnd of the program\n")