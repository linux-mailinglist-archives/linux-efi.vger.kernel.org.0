Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F083154634
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2020 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBFObV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 09:31:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727906AbgBFObV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Feb 2020 09:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580999479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZlYm4Tgk3vllYwZcS0tXn0XDA45dEm4D/gYcoReQjk=;
        b=TXzxhI2jTJ3H0OIgMF99iTUuw8GdZjLqy5IIuf9YCIoHuIrk83ZtXf3h742J82Ev96uzeO
        aZaVpUNVh40VdtfS1SG20IyaRCf1foZnHEHLn0Eiqwdjyxs9OxQUX6jM8X4aKH/VxReTsZ
        FtLCRyuODkR27UpAjM+KuDZkMERadg8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-xjMxkhNjN7uAifmBYpQV8Q-1; Thu, 06 Feb 2020 09:31:04 -0500
X-MC-Unique: xjMxkhNjN7uAifmBYpQV8Q-1
Received: by mail-wr1-f72.google.com with SMTP id d15so3481030wru.1
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2020 06:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZlYm4Tgk3vllYwZcS0tXn0XDA45dEm4D/gYcoReQjk=;
        b=cJXP6hRKdlq0zlOm+VOW1CQHgjQ1bXoi6jRhbcsTGbYUwS2GRC4p9mdPYsWh3+AbHo
         UKOi5yFSCq38ZYWr38t9KkZ8jWwOmGuSG7Fmn7kL31+w5mpi1Kuu6S35xqkfCg1fwegj
         RVd8035C22ECONUi2eT4X59vkMqhWUebitesXKVUltdolXVKCibjYzWbQ7KKpFUWYPtk
         UBD8s9l4QtNIyV1c5jIvU/w+qPFN3a9VhSNmoJSIVkpZzS7k6hM+rXKqh0hh+zUZh9sJ
         tpJYAHgd8sNCZPl1AtBiT+PSjXp0qxQVm5Tr2XJPFxu3aw7FUWKvNqV9KpKBLBFLwQ/K
         sErg==
X-Gm-Message-State: APjAAAX56KGWYCSX0X4oYOMXxjzHA3K2tzClvhOKJ2MS/mUmf+BqlFbh
        HH+0tI89ZcWsnHskZ7W5gTqn11qR+aYnxJtC+Cvl/wJLS3V+kfhMs96ZwaNSmE+UjSv+IwQ6NLI
        grvS1SKYSvMpDOSYHqFHK
X-Received: by 2002:adf:f803:: with SMTP id s3mr4069461wrp.7.1580999461875;
        Thu, 06 Feb 2020 06:31:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYLQVqIQm6HM48PKN6RZvbom0oFpS1nNVt8SmMC75HdY95WE0G6gZgcvDtR2gatp7OjtNefw==
X-Received: by 2002:adf:f803:: with SMTP id s3mr4069427wrp.7.1580999461431;
        Thu, 06 Feb 2020 06:31:01 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id x10sm4585657wrp.58.2020.02.06.06.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:31:00 -0800 (PST)
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-22-ardb@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0a31756e-d554-ff1c-5809-130d516714ae@redhat.com>
Date:   Thu, 6 Feb 2020 15:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191218170139.9468-22-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Add an option to disable the busmaster bit in the control register on
> all PCI bridges during the invocation of ExitBootServices() and passing
> control to the runtime kernel. System firmware may configure the IOMMU
> to prevent malicious PCI devices from being able to attack the OS via DMA.
> However, since firmware can't guarantee that the OS is IOMMU-aware, it
> will tear down IOMMU configuration when ExitBootServices() is called.
> This leaves a window between where a hostile device could still cause
> damage before Linux configures the IOMMU again.
> 
> If CONFIG_EFI_DISABLE_PCI_DMA is enabled or the "efi=disable_pci_dma"
> command line argument is passed, the EFI stub will clear the busmaster
> bit on all PCI bridges before ExitBootServices() completes. This will
> prevent any malicious PCI devices from being able to perform DMA until
> the kernel reenables busmastering after configuring the IOMMU.
> 
> This option is disabled when in EFI mixed mode environments (ie, 64-bit
> kernels with a 32-bit EFI implementation), given that the use of EFI
> events is not supported in this case.
> 
> This option may cause failures with some poorly behaved hardware and
> should not be enabled without testing. The kernel commandline options
> "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be used to
> override the default.
> 
> Co-developed-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> [ardb: use EFI events to defer DMA disabling to the end of ExitBootServices()]
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I guess this might not be the latest version of this patch, but
this does seem to be the thread where most discussion on it
has happened.

My personal kernel tree atm consists of v5.5 + efi/next + my own patches
and yesterday I noticed that will not boot on a Lenovo X1 7th gen connected
to a Lenovo thunderbolt 3 gen 2 dock.

My first hunch was that I have CONFIG_EFI_DISABLE_PCI_DMA=y and that that
was causing it and indeed that is the problem.

So as (somewhat) expected CONFIG_EFI_DISABLE_PCI_DMA=y indeed stops the kernel
from booting on some systems.

When I hit this problem the efistub prints 2 messages and then the system
just hangs:

exit_boot() failed!
efi_main() failed!

When I boot the system without it being connected to the thunderbolt dock
then efi=disable_pci_dma works fine.

Let me know if I can do anything to help and getting booting while
connected to the dock to work with efi=disable_pci_dma.

Regards,

Hans



> ---
>   Documentation/admin-guide/kernel-parameters.txt |   4 +
>   arch/x86/boot/compressed/eboot.c                |   2 +
>   drivers/firmware/efi/Kconfig                    |  22 ++++
>   drivers/firmware/efi/libstub/Makefile           |   2 +-
>   drivers/firmware/efi/libstub/arm-stub.c         |   1 +
>   drivers/firmware/efi/libstub/efi-stub-helper.c  |  17 +++
>   drivers/firmware/efi/libstub/efistub.h          |   1 +
>   drivers/firmware/efi/libstub/pci.c              | 116 ++++++++++++++++++++
>   include/linux/efi.h                             |   2 +
>   9 files changed, 166 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5a92d89a1bd4..06fd8d2c9a2c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1180,6 +1180,10 @@
>   			claim. Specify efi=nosoftreserve to disable this
>   			reservation and treat the memory by its base type
>   			(i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
> +			disable_pci_dma: Disable the busmaster bit on all
> +			PCI bridges while in the EFI boot stub
> +			no_disable_pci_dma: Leave the busmaster bit set on all
> +			PCI bridges while in the EFI boot stub
>   
>   	efi_no_storage_paranoia [EFI; X86]
>   			Using this parameter you can use more than 50% of
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index a3000283dc7a..79c3c3308195 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -126,6 +126,8 @@ static void setup_efi_pci(struct boot_params *params)
>   	efi_handle_t h;
>   	int i;
>   
> +	efi_pci_disable_bridge_busmaster();
> +
>   	status = efi_call_early(locate_handle,
>   				EFI_LOCATE_BY_PROTOCOL,
>   				&pci_proto, NULL, &size, pci_handle);
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index bcc378c19ebe..da2f5fc862aa 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -215,6 +215,28 @@ config EFI_RCI2_TABLE
>   
>   	  Say Y here for Dell EMC PowerEdge systems.
>   
> +config EFI_DISABLE_PCI_DMA
> +       bool "Clear Busmaster bit on PCI bridges during ExitBootServices()"
> +       help
> +	  Disable the busmaster bit in the control register on all PCI bridges
> +	  while calling ExitBootServices() and passing control to the runtime
> +	  kernel. System firmware may configure the IOMMU to prevent malicious
> +	  PCI devices from being able to attack the OS via DMA. However, since
> +	  firmware can't guarantee that the OS is IOMMU-aware, it will tear
> +	  down IOMMU configuration when ExitBootServices() is called. This
> +	  leaves a window between where a hostile device could still cause
> +	  damage before Linux configures the IOMMU again.
> +
> +	  If you say Y here, the EFI stub will clear the busmaster bit on all
> +	  PCI bridges before ExitBootServices() completes. This will prevent
> +	  any malicious PCI devices from being able to perform DMA until the
> +	  kernel reenables busmastering after configuring the IOMMU.
> +
> +	  This option will cause failures with some poorly behaved hardware
> +	  and should not be enabled without testing. The kernel commandline
> +	  options "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be
> +	  used to override this option.
> +
>   endmenu
>   
>   config UEFI_CPER
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index c35f893897e1..98a81576213d 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -39,7 +39,7 @@ OBJECT_FILES_NON_STANDARD	:= y
>   KCOV_INSTRUMENT			:= n
>   
>   lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
> -				   random.o
> +				   random.o pci.o
>   
>   # include the stub's generic dependencies from lib/ when building for ARM/arm64
>   arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index e1ec0b2cde29..aa2929098d60 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -257,6 +257,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>   	}
>   
>   	install_memreserve_table();
> +	efi_pci_disable_bridge_busmaster();
>   
>   	new_fdt_addr = fdt_addr;
>   	status = allocate_new_fdt_and_exit_boot(handle,
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 8b0d59f5c8cd..4b79bfff1fd4 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -33,6 +33,8 @@ static bool __section(.data) efi_nokaslr;
>   static bool __section(.data) efi_quiet;
>   static bool __section(.data) efi_novamap;
>   static bool __section(.data) efi_nosoftreserve;
> +static bool __section(.data) efi_disable_pci_dma =
> +					IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
>   
>   bool __pure nokaslr(void)
>   {
> @@ -51,6 +53,11 @@ bool __pure __efi_soft_reserve_enabled(void)
>   	return !efi_nosoftreserve;
>   }
>   
> +bool __pure disable_pci_dma(void)
> +{
> +	return efi_disable_pci_dma;
> +}
> +
>   #define EFI_MMAP_NR_SLACK_SLOTS	8
>   
>   struct file_info {
> @@ -499,6 +506,16 @@ efi_status_t efi_parse_options(char const *cmdline)
>   			efi_nosoftreserve = true;
>   		}
>   
> +		if (!strncmp(str, "disable_pci_dma", 15)) {
> +			str += strlen("disable_pci_dma");
> +			efi_disable_pci_dma = true;
> +		}
> +
> +		if (!strncmp(str, "no_disable_pci_dma", 18)) {
> +			str += strlen("no_disable_pci_dma");
> +			efi_disable_pci_dma = false;
> +		}
> +
>   		/* Group words together, delimited by "," */
>   		while (*str && *str != ' ' && *str != ',')
>   			str++;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 72e60b6afbf8..679268f67521 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -28,6 +28,7 @@
>   extern bool __pure nokaslr(void);
>   extern bool __pure is_quiet(void);
>   extern bool __pure novamap(void);
> +extern bool __pure disable_pci_dma(void);
>   
>   extern __pure efi_system_table_t  *efi_system_table(void);
>   
> diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
> new file mode 100644
> index 000000000000..e2f71f890dd1
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/pci.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI-related functions used by the EFI stub on multiple
> + * architectures.
> + *
> + * Copyright 2019 Google, LLC
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/pci.h>
> +
> +#include <asm/efi.h>
> +
> +#include "efistub.h"
> +
> +static efi_event_t __section(.data) exit_boot_services_event;
> +static efi_event_t __section(.data) disable_pci_dma_event;
> +
> +static efi_handle_t *__section(.data) pci_handle;
> +static unsigned long __section(.data) pci_handle_size;
> +
> +static efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
> +
> +static void __efiapi handle_exit_boot_services_event(efi_event_t event,
> +						     void *context)
> +{
> +	efi_call_early(signal_event, disable_pci_dma_event);
> +}
> +
> +static void __efiapi handle_disable_pci_dma_event(efi_event_t event,
> +						  void *context)
> +{
> +	efi_handle_t handle;
> +	efi_status_t status;
> +	u16 class, command;
> +	int i;
> +
> +	for_each_efi_handle(handle, pci_handle, pci_handle_size, i) {
> +		efi_pci_io_protocol_t *pci = NULL;
> +
> +		status = efi_call_early(handle_protocol, handle,
> +					&pci_proto, (void **)&pci);
> +		if (status != EFI_SUCCESS || !pci)
> +			continue;
> +
> +		status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
> +					PCI_CLASS_DEVICE, 1, &class);
> +
> +		if (status != EFI_SUCCESS || class != PCI_CLASS_BRIDGE_PCI)
> +			continue;
> +
> +		/* Disable busmastering */
> +		status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
> +					PCI_COMMAND, 1, &command);
> +		if (status != EFI_SUCCESS || !(command & PCI_COMMAND_MASTER))
> +			continue;
> +
> +		command &= ~PCI_COMMAND_MASTER;
> +		status = efi_call_proto(pci, pci.write, EfiPciIoWidthUint16,
> +					PCI_COMMAND, 1, &command);
> +		if (status != EFI_SUCCESS)
> +			pr_efi_err("Failed to disable PCI busmastering\n");
> +	}
> +}
> +
> +void efi_pci_disable_bridge_busmaster(void)
> +{
> +	efi_status_t status;
> +
> +	if (!disable_pci_dma() || !efi_is_native())
> +		return;
> +
> +	status = efi_call_early(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> +				&pci_proto, NULL, &pci_handle_size, pci_handle);
> +
> +	if (status != EFI_BUFFER_TOO_SMALL) {
> +		if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
> +			pr_efi_err("Failed to locate PCI I/O handles'\n");
> +		return;
> +	}
> +
> +	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
> +				pci_handle_size, (void **)&pci_handle);
> +	if (status != EFI_SUCCESS) {
> +		pr_efi_err("Failed to allocate memory for 'pci_handle'\n");
> +		return;
> +	}
> +
> +	status = efi_call_early(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> +				&pci_proto, NULL, &pci_handle_size, pci_handle);
> +	if (status != EFI_SUCCESS) {
> +		pr_efi_err("Failed to locate PCI I/O handles'\n");
> +		goto free_handle;
> +	}
> +
> +	status = efi_call_early(create_event, EVT_NOTIFY_SIGNAL,
> +				TPL_CALLBACK, handle_disable_pci_dma_event,
> +				NULL, &disable_pci_dma_event);
> +	if (status != EFI_SUCCESS) {
> +		pr_efi_err("Failed to create event to disable PCI DMA\n");
> +		goto free_handle;
> +	}
> +
> +	status = efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SERVICES,
> +				TPL_CALLBACK, handle_exit_boot_services_event,
> +				NULL, &exit_boot_services_event);
> +	if (status != EFI_SUCCESS) {
> +		pr_efi_err("Failed to register for EBS() event\n");
> +		goto free_handle;
> +	}
> +
> +	return;
> +
> +free_handle:
> +	efi_call_early(free_pool, pci_handle);
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 81bd1e8c201f..2864633abff0 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1786,4 +1786,6 @@ struct linux_efi_memreserve {
>   #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
>   	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
>   
> +void efi_pci_disable_bridge_busmaster(void);
> +
>   #endif /* _LINUX_EFI_H */
> 

