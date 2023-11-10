Return-Path: <linux-efi+bounces-19-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01A7E76AE
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 02:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69397B20CFE
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB83A47;
	Fri, 10 Nov 2023 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jJPFmxSb"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF52A46
	for <linux-efi@vger.kernel.org>; Fri, 10 Nov 2023 01:39:32 +0000 (UTC)
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D144BF;
	Thu,  9 Nov 2023 17:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6396; q=dns/txt; s=iport;
  t=1699580372; x=1700789972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=18cNsTNuiRDR0CKbESUnPHmzPvgXjxbhXvQdZpLLd3E=;
  b=jJPFmxSbS8TGTke58aPBjycXJg2mh04+ndS8OsPk213/XuTGblx74JCi
   euyeL7pWY5fYFXkbyCKWeXkNff9YxsAXl9e1pNmNk3TnCv0CM2h1FNfhA
   O2fEvyEiEXNnZIQnef0N87hOdpV2cPfORSP+T1a9g5PC0KmlKPb8ojySy
   s=;
X-CSE-ConnectionGUID: D0vmuO0vRjqFrfnxF9Eo0g==
X-CSE-MsgGUID: 4eBf7R0bRICauPeKld8sbw==
X-IPAS-Result: =?us-ascii?q?A0ANAABsiE1lmJtdJa1aHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBhAdASIxviUKeAYElA1YPAQEBD0QEAQGFBgKHJgImNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ4V1hk0DAycLA?=
 =?us-ascii?q?UYQUVcGARKCfoJfA61YgXkzgQGzKIFoGIEwAYxDgR6ENScbgUlEgRWBO4Iti?=
 =?us-ascii?q?wYEiSUHMoIig1KNS39HWhYdAwcDVikQKwcELSIGCRQtIwZRBBcRJAkTEj4Eg?=
 =?us-ascii?q?WOBUQp/Pw8OEYI/IgIHNjYZSIJbFUAERnYQKgQUF4ESbhsVHjcREhcNAwh0H?=
 =?us-ascii?q?QIRIzwDBQMEMwoSDQshBRRCA0IGSQsDAhoFAwMEgTYFDR4CEC0nAwMTTQIQF?=
 =?us-ascii?q?AM7AwMGAwsxAzBVRAxRA28fGhwJPA8MHwIbHg0nKAI1QwMRBRICFgMkGQRFA?=
 =?us-ascii?q?wkDBwVJQAMLGA1IESw1Bg4bBj9zB6FVPVIwGwKCVZIoFQcCAZFSgTGdX4E3h?=
 =?us-ascii?q?BeBX5wkgwYaM6oDmD8gonCFQYFjOoFbMxoIGxWDIlIZD44sDQmTEgFdIzI7A?=
 =?us-ascii?q?gcLAQEDCYZLhH8BAQ?=
IronPort-Data: A9a23:rhVaWawIuIS5buo7e6l6t+flwSrEfRIJ4+MujC+fZmUNrF6WrkUOz
 mFJXjvUbPeCMGD3fItwO4qw80IHvJbVyIJiGwo9pFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YiaT/H3Ygf/gGctazpMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu1OfZJGWY6dKpzVToaXXq09s/IUZuMthNkgp3KTkmG
 f0wMjsBaFWIgPi7he79Qeh3jcNlJ87uVG8dkig/lneCUrB3GtaaHviiCdxwhF/cguhCFPDfa
 s4GYBJkbQ/LZFtEPVJ/5JcWxbz13iChL2QHwL6TjfY6yWaM9lR76pnGOcftd/+OSZVOlFnN8
 woq+EygUk1Fa7Rz0wGt9nOqm/+Kni7hXo8WPKO3++Qsg1CJwGEXThoMWjOTpfi/l177VtxeA
 1Ib9zBorqUo8kGvCN7nUHWQqWSItDYfVsBWHul87xuCooLQ4gCEFnAcRXtNZcIOsM4tWSds0
 U2NltnyQzt1v9W9TXOb66fRqDKqIgALImIYIywJVw0I55/kuo5bpgKfEP5gHbSzg9mzHiv/q
 xiRoSE4wbwVgcMRzKK91UvKiDXqrZ/MJiYp4QDeRSSg8w9jeYimbqSn7FHa6bBLK4PxZkCcv
 XMzg8KE5eALBLmUiS2GQeMGWrqu4p6tOT7EhHZrHp8853Gj/GOlcYlM4TZ4YkBzPa4sdTbvY
 ULXkQxQ4YdeOHa0bKR3JZm4DYEk16HmHtX+XfeSZdMIf4MZXBWA9iFGZkOK2W3p1k82nskXM
 peBcN2wCm4aBOJjwSCxVs8WyrAxwT0mg27OLbjkzhCj+bmTfniYTfECKlTmUwwixLmPrAOQ+
 NFFOo7WjR5eS+b5JCLQ9Ob/MGzmM1AXXY7ztusPaNSBOyR8FmcxJa78xusuLtkNc7tuqs/E+
 XS0W0l9wVX5hGHaJQjiVpyFQO6xNXqYhS9mVRHALWpEyFB4PtnytPZ3m48fOOh4pLY6nJaYW
 tFcI53YasmjXAgr7Nj0UHUQhJZpeBLujgWUMm/5JjM+ZJVnAQfO/7cInzcDFgFQUkJbVuNn/
 tVMMz83p7JfG2yO6+6KMJqSI6uZ5yR1pQ6LdxKgziNvUEvt6pN2DCf6k+U6JcoBQT2amGrLi
 lvKX0tI/raRy2PQzDUvrf7dx2tOO7Umdne240GHhVpLHXCApzH6kdMovBigJ2yHCgsYB5lOl
 c0Mn62jb5XrbX5BspF3FP5w3Lki6t70z4K2PSw6dEgnm2+DU+s6SlHfhJEnnvQUmtdx51DsM
 mrRoYYyBFl8EJ6/eLLnDFB7Pr3rODB9smS60MnZ122jv38voOrYARkCV/RO4QQERIZI3Eoe6
 b9JkKYrB8aX03LG7v7uYvhoylmx
IronPort-HdrOrdr: A9a23:EhAwAKCsAXGH8yrlHemX55DYdb4zR+YMi2TDGXocdfUzSL39qy
 nAppomPHPP4gr5HUtQ+uxoW5PwJE80i6QV3WB5B97LNzUO+lHYTr2KhrGM/9SPIUDDH8dmpM
 BdmtBFaOEZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: 9a23:t/nNLm6e/652txrJltss2BYKH90CKmPnzm7+OUG+GUg4ZbrNRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A0eoxMg12us+7xDL05uML/17/9DUjv6mEBh83yZ8?=
 =?us-ascii?q?8muKNKBR9GDOR3C+9Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,291,1694736000"; 
   d="scan'208";a="135016417"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 01:38:30 +0000
Received: from goliath.lan ([10.25.128.169])
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 3AA1cHVL011466;
	Fri, 10 Nov 2023 01:38:29 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: xe-linux-external@cisco.com, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic commandline
Date: Thu,  9 Nov 2023 17:38:09 -0800
Message-Id: <20231110013817.2378507-6-danielwa@cisco.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110013817.2378507-1-danielwa@cisco.com>
References: <20231110013817.2378507-1-danielwa@cisco.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.128.169, [10.25.128.169]
X-Outbound-Node: rcdn-core-4.cisco.com

This adds code to handle the generic command line changes.
The efi code appears that it doesn't benefit as much from this design
as it could.

For example, if you had a prepend command line with "nokaslr" then
you might be helpful to re-enable it in the boot loader or dts,
but there appears to be no way to re-enable kaslr or some of the
other options.

The efi command line handling is incorrect. x86 and arm have an append
system however the efi code prepends the command line.

For example, you could have a non-upgradable bios which sends

efi=disable_early_pci_dma

This hypothetically could have been set because early pci dma caused
issues on early versions of the product.

Then later the early pci dma was made to work and the company desired
to start using it. To override the bios you could set the CONFIG_CMDLINE
to,

efi=no_disable_early_pci_dma

then parsing would normally start with the bios command line, then move
to the CONFIG_CMDLINE and you would end up with early pci dma turned on.

however, current efi code keeps early pci dma off because the bios
arguments always override the built in.

Per my reading this is different from the main body of x86, arm, and
arm64.

The generic command line provides both append and prepend, so it
alleviates this issue if it's used. However not all architectures use
it.

It would be desirable to allow the efi stub to have it's builtin command
line to be modified after compile, but I don't see a feasible way to do
that currently.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 29 +++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       |  9 ++++++
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 drivers/firmware/efi/libstub/x86-stub.c       | 14 +++++++--
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..952fa2cdff51 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -11,6 +11,7 @@
 
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/cmdline.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -29,6 +30,34 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
+/**
+ * efi_handle_cmdline() - handle adding in built-in parts of the command line
+ * @cmdline:	kernel command line
+ *
+ * Add in the generic parts of the commandline and start the parsing of the
+ * command line.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_handle_builtin_cmdline(char const *cmdline)
+{
+	efi_status_t status = EFI_SUCCESS;
+
+	if (sizeof(CMDLINE_STATIC_PREPEND) > 1)
+		status |= efi_parse_options(CMDLINE_STATIC_PREPEND);
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
+		status |= efi_parse_options(cmdline);
+
+	if (sizeof(CMDLINE_STATIC_APPEND) > 1)
+		status |= efi_parse_options(CMDLINE_STATIC_APPEND);
+
+	if (status != EFI_SUCCESS)
+		efi_err("Failed to parse options\n");
+
+	return status;
+}
+
 /**
  * efi_parse_options() - Parse EFI command line options
  * @cmdline:	kernel command line
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f9c1e8a2bd1d..770abe95c0ee 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -127,6 +127,14 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
+#ifdef CONFIG_GENERIC_CMDLINE
+	status = efi_handle_builtin_cmdline(cmdline);
+	if (status != EFI_SUCCESS) {
+		goto fail_free_cmdline;
+	}
+#endif
+
+#ifdef CONFIG_CMDLINE
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
 	    cmdline_size == 0) {
@@ -144,6 +152,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 			goto fail_free_cmdline;
 		}
 	}
+#endif
 
 	*cmdline_ptr = cmdline;
 	return EFI_SUCCESS;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..1ac6631905c5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -996,6 +996,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long alignment,
 				 unsigned long min_addr);
 
+efi_status_t efi_handle_builtin_cmdline(char const *cmdline);
 efi_status_t efi_parse_options(char const *cmdline);
 
 void efi_parse_option_graphics(char *option);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 9d5df683f882..273a8a9c8bbb 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -847,6 +847,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	struct setup_header *hdr = &boot_params->hdr;
 	const struct linux_efi_initrd *initrd = NULL;
 	unsigned long kernel_entry;
+	unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+				       ((u64)boot_params->ext_cmd_line_ptr << 32));
 	efi_status_t status;
 
 	boot_params_pointer = boot_params;
@@ -877,6 +879,14 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+#ifdef CONFIG_GENERIC_CMDLINE
+	status = efi_handle_builtin_cmdline((char *)cmdline_paddr);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to parse options\n");
+		goto fail;
+	}
+#else /* CONFIG_GENERIC_CMDLINE */
+
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
@@ -885,8 +895,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	}
 #endif
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
-		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
-					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = efi_parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
@@ -894,6 +902,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		}
 	}
 
+#endif
+
 	status = efi_decompress_kernel(&kernel_entry);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
-- 
2.39.2


