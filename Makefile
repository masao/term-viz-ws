WSDL2RUBY = $(HOME)/CVSwork/soap4r/bin/wsdl2ruby.rb
WSDL2RUBY_OPT = --type server --type client --cgiStub --force

TARGET = GraphViz.rb Term.rb

all: $(TARGET)

GraphViz.rb: graphviz.wsdl
	$(WSDL2RUBY) --wsdl graphviz.wsdl $(WSDL2RUBY_OPT)

Term.rb: term-viz.wsdl
	$(WSDL2RUBY) --wsdl $< $(WSDL2RUBY_OPT)
