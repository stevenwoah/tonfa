RM=/bin/rm
PACKER=/usr/local/bin/packer
PACKER_DIR=packer
VAGRANT=/usr/bin/vagrant

tonfa-build-box:
	@echo "Building tonfa-build-box with Packer..."
	@cd $(PACKER_DIR) && \
	$(PACKER) build --force tonfa-build-box.json
	@echo "Adding box to Vagrant boxes..."
	@$(VAGRANT) box add $(PACKER_DIR)/tonfa-build-box-virtualbox.box --name tonfa-build-box --force && \
	$(RM) $(PACKER_DIR)/tonfa-build-box-virtualbox.box

