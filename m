Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD61BE6BB
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 20:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD2S5H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 14:57:07 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:54012 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2S5H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 14:57:07 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id EB9FE1800AEBF
        for <linux-efi@vger.kernel.org>; Wed, 29 Apr 2020 18:47:51 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 75836483C;
        Wed, 29 Apr 2020 18:47:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:966:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3871:3872:4321:4385:5007:6691:7974:8603:9040:10004:11026:11232:11473:11657:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13439:14181:14659:14721:21080:21212:21324:21325:21433:21451:21627:21660:21990:30012:30046:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kick44_a1d68a6ba161
X-Filterd-Recvd-Size: 5691
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 18:47:49 +0000 (UTC)
Message-ID: <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
From:   Joe Perches <joe@perches.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 11:47:48 -0700
In-Reply-To: <20200429174120.1497212-5-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
         <20200429174120.1497212-5-nivedita@alum.mit.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> Use pr_efi_err instead of bare efi_printk for error messages.

Perhaps it'd be better to rename pr_efi_err to eri_err
to it's clearer it's a typical efi_ logging function.

$ git grep -w --name-only pr_efi_err | \
  xargs sed -i 's/\bpr_efi_err\b/efi_err/g'

Looking at code for efi_printk -> efi_char16_printk,
it's somewhat difficult to see where the "output_string"
function pointer is set.  Any clue?

> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 677b5a1e0543..933205772d8c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -49,7 +49,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>  			     (void **)&rom);
>  	if (status != EFI_SUCCESS) {
> -		efi_printk("Failed to allocate memory for 'rom'\n");
> +		pr_efi_err("Failed to allocate memory for 'rom'\n");
>  		return status;
>  	}
>  
> @@ -65,7 +65,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  				PCI_VENDOR_ID, 1, &rom->vendor);
>  
>  	if (status != EFI_SUCCESS) {
> -		efi_printk("Failed to read rom->vendor\n");
> +		pr_efi_err("Failed to read rom->vendor\n");
>  		goto free_struct;
>  	}
>  
> @@ -73,7 +73,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  				PCI_DEVICE_ID, 1, &rom->devid);
>  
>  	if (status != EFI_SUCCESS) {
> -		efi_printk("Failed to read rom->devid\n");
> +		pr_efi_err("Failed to read rom->devid\n");
>  		goto free_struct;
>  	}
>  
> @@ -118,7 +118,7 @@ static void setup_efi_pci(struct boot_params *params)
>  				     (void **)&pci_handle);
>  
>  		if (status != EFI_SUCCESS) {
> -			efi_printk("Failed to allocate memory for 'pci_handle'\n");
> +			pr_efi_err("Failed to allocate memory for 'pci_handle'\n");
>  			return;
>  		}
>  
> @@ -172,7 +172,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
>  		return;
>  
>  	if (efi_table_attr(p, version) != 0x10000) {
> -		efi_printk("Unsupported properties proto version\n");
> +		pr_efi_err("Unsupported properties proto version\n");
>  		return;
>  	}
>  
> @@ -185,7 +185,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
>  				     size + sizeof(struct setup_data),
>  				     (void **)&new);
>  		if (status != EFI_SUCCESS) {
> -			efi_printk("Failed to allocate memory for 'properties'\n");
> +			pr_efi_err("Failed to allocate memory for 'properties'\n");
>  			return;
>  		}
>  
> @@ -372,7 +372,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  
>  	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
>  	if (status != EFI_SUCCESS) {
> -		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
> +		pr_efi_err("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
>  		efi_exit(handle, status);
>  	}
>  
> @@ -382,7 +382,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	status = efi_allocate_pages(sizeof(struct boot_params),
>  				    (unsigned long *)&boot_params, ULONG_MAX);
>  	if (status != EFI_SUCCESS) {
> -		efi_printk("Failed to allocate lowmem for boot params\n");
> +		pr_efi_err("Failed to allocate lowmem for boot params\n");
>  		efi_exit(handle, status);
>  	}
>  
> @@ -749,7 +749,7 @@ unsigned long efi_main(efi_handle_t handle,
>  					     hdr->kernel_alignment,
>  					     LOAD_PHYSICAL_ADDR);
>  		if (status != EFI_SUCCESS) {
> -			efi_printk("efi_relocate_kernel() failed!\n");
> +			pr_efi_err("efi_relocate_kernel() failed!\n");
>  			goto fail;
>  		}
>  		/*
> @@ -786,7 +786,7 @@ unsigned long efi_main(efi_handle_t handle,
>  			efi_set_u64_split(size, &hdr->ramdisk_size,
>  					  &boot_params->ext_ramdisk_size);
>  		} else if (status != EFI_NOT_FOUND) {
> -			efi_printk("efi_load_initrd_dev_path() failed!\n");
> +			pr_efi_err("efi_load_initrd_dev_path() failed!\n");
>  			goto fail;
>  		}
>  	}
> @@ -813,13 +813,13 @@ unsigned long efi_main(efi_handle_t handle,
>  
>  	status = exit_boot(boot_params, handle);
>  	if (status != EFI_SUCCESS) {
> -		efi_printk("exit_boot() failed!\n");
> +		pr_efi_err("exit_boot() failed!\n");
>  		goto fail;
>  	}
>  
>  	return bzimage_addr;
>  fail:
> -	efi_printk("efi_main() failed!\n");
> +	pr_efi_err("efi_main() failed!\n");
>  
>  	efi_exit(handle, status);
>  }

