const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", ()=>{
it("should set the message", async()=>{
    const instance = await HelloWorld.deployed();
    await instance.setMessage("Hello World changed, now it's Hello Blockchain World");
    const message = await instance.getMessage();
    assert(message === "Hello World changed, now it's Hello Blockchain World");

});})