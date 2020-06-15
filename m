Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD41FA4A8
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 01:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgFOXmu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 19:42:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:46999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFOXmt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 19:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592264559;
        bh=WT+TxHRnNU7lFrgyELSoJ33WMA/qduMem0JA8iUXVIA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UjRH/WD0vg7CHMUrsHSo6fXTtzwMZ68LPCjkvSQKeKYk9ijLM1hD1gi6jsBz1gFSA
         SRWIJxMNiQ6wRqi2zp+OhcBiYHJ+5J2pvpyWFnzU1wG/vv+dVPG7RRjbREXxalwrdd
         1EH8hk8UcxoBsVYg5qNBvsDFTPIXW+bJ//7PhYrY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([109.41.66.174]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MbAcs-1j9jBW1oqm-00baxX; Tue, 16 Jun 2020 01:42:38 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: descriptions for stub helper functions
Date:   Tue, 16 Jun 2020 01:42:31 +0200
Message-Id: <20200615234231.21059-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pWme2yQtst5JtW7roXB8YmTxBbB4cwL3ZOTsMbvvNKEep+/Kxtq
 f5kMMbtOF7wbqIvvbImLvwjPZHmNk54YA8P2N3zOj9Aitps5vQQ6iYAX2Cbcft/eiIOr3XC
 7OM5q49Eja1Vsf2CVF+sf8bEqOM07qFkcdAlnNFEYOBkhHzhpdOyB91V9SppUpM6psVFIhm
 icRT37CNMHob4KTKlloYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+J8yanFVCDw=:aWxI6lNcTGx5lNp8Q+cMns
 n9EmdVS8WaROGL6L6wVUTPIJlOqqzGzLlY2M83MRv8FQNkAcReI3QYR1kCtx6DRqZCkTm8rqA
 ah73cGXb+7eu/hkR7yvGvI7MtbUwKCociSP9jPKqud0qn9gzMSokRbcGjFfPvUoMt1QK0IQrK
 i8OTBOBeMAQC4lAmcT68sLDaUHq1hq8K/QypapFelmJHKtYRHMDw3+M326Fxi+p5mID8ie2M5
 RF4TWcNFW/oOQR37OKGw56NmzCmE53uQSznl7dDzzmkxH8UBTaWM9VOefCUhBSe4B7YGIAnYf
 ffMBG6Qlj2VgQXYteA7JdKaRWPeHMTK4nFzzPp1BI4esZQ2EBIuPL+h/8qOPylhmMReiz/7iv
 n743y7u+MA+vDd/bhngqr56ARAvUzy99SoeX85YgojWeeu6Mj8iyxMbgE7cHkoaZ8ccQBmEXf
 JBPt3XOuUGQYMhSHC/TXfXpiNpfDPKzma+Au5oslx3Cg1TDlb1x22JGJBUKTAxcYWIdZeNSH6
 X/HA0EItJ4E8cwGcoaddendVS/O1dYWGE8CR6NSW4TUsqtOdtKKflTBxaKr/dLpozH4AwefV9
 Bmay/Yo0C6C0dSovydMaYmSSLIHTQTAevxyrZyzxSA6bf4mObExwY4lAsi8voGlxz+iszfmud
 Dgys+q2bIuY7u7dtf75p9XrlXx+7hSFgeGIUSurhGAqt+P4U/5WtmrGriBcxPidFX2y3wwzKQ
 ZtTmmpsl4fQ9+IrFeyuKcfNRArRXqO8u+hnR9/owA/gC8tNOFgBn4i3m+llCWw3XZVX+5ZKi5
 mGSL+1R0E77p9PPazafXrwkHOaEfj4O76/Pf9xknPdppnp5VPh9M2NUxjjqlYfoped81P+awm
 za1v6jkX0S/34dvv2SYchCwdeaPd0Vz7nrRYDLOws1wBLXK2oc3CmkCFvvkuTZqAbzIb3is/F
 HaTWVgOl/itqRVvYGLcv0zC0EzQ8qHlA9mgCHXMynVLy1W9GMxopifmXaphHBsQEYMHHAgnCm
 t6h9WrWq3tyM8IbXnc2cVTroljiEGWq3fbup60Cfmed5uSjHNAdTZZUr2ECOPNsgEOCtDn51D
 +YQgnMVr9OF89DpGB0/gSwErsvrO/1Tsj9lvuNWWlOD9zIgWNcnj5eMWnjdraSZRYHVEny0ll
 3wWEmsUCwcDRMGF3X1Md/UsX0zQzGTJQxk94RZ9QylpJqg6HRIvXYu1a1+i9efB7oRJZFKHyo
 Qu82RIYWSAZryDuks
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Provide missing descriptions for EFI stub helper functions.
Adjust formatting of existing descriptions to kernel style.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 .../firmware/efi/libstub/efi-stub-helper.c    | 78 ++++++++++++++++---
 drivers/firmware/efi/libstub/efistub.h        | 10 ++-
 2 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firm=
ware/efi/libstub/efi-stub-helper.c
index 89f075275300..d40fd68c6bb2 100644
=2D-- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -32,6 +32,10 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }

+/**
+ * efi_char16_puts() - Write a UCS-2 encoded string to the console
+ * @str:	UCS-2 encoded string
+ */
 void efi_char16_puts(efi_char16_t *str)
 {
 	efi_call_proto(efi_table_attr(efi_system_table, con_out),
@@ -83,6 +87,10 @@ u32 utf8_to_utf32(const u8 **s8)
 	return c32;
 }

+/**
+ * efi_puts() - Write a UTF-8 encoded string to the console
+ * @str:	UTF-8 encoded string
+ */
 void efi_puts(const char *str)
 {
 	efi_char16_t buf[128];
@@ -113,6 +121,16 @@ void efi_puts(const char *str)
 	}
 }

+/**
+ * efi_printk() - Print a kernel message
+ * @fmt:	format string
+ *
+ * The first letter of the format string is used to determine the logging=
 level
+ * of the message. If the level is less then the current EFI logging leve=
l, the
+ * message is suppressed. The message will be truncated to 255 bytes.
+ *
+ * Return:	number of printed characters
+ */
 int efi_printk(const char *fmt, ...)
 {
 	char printf_buf[256];
@@ -154,13 +172,18 @@ int efi_printk(const char *fmt, ...)
 	return printed;
 }

-/*
- * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
=3D
+/**
+ * efi_parse_options() - Parse EFI command line options
+ * @cmdline:	kernel command line
+ *
+ * Parse the ASCII string @cmdline for EFI options, denoted by the efi=3D
  * option, e.g. efi=3Dnochunk.
  *
  * It should be noted that efi=3D is parsed in two very different
  * environments, first in the early boot environment of the EFI boot
  * stub, and subsequently during the kernel boot.
+ *
+ * Return:	status code
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
@@ -286,13 +309,21 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,=
 int *cmd_line_len)
 	return (char *)cmdline_addr;
 }

-/*
+/**
+ * efi_exit_boot_services() - Exit boot services
+ * @handle:	handle of the exiting image
+ * @map:	pointer to receive the memory map
+ * @priv:	argument to be passed to @priv_func
+ * @priv_func:	function to process the memory map before exiting boot ser=
vices
+ *
  * Handle calling ExitBootServices according to the requirements set out =
by the
  * spec.  Obtains the current memory map, and returns that info after cal=
ling
  * ExitBootServices.  The client must specify a function to perform any
  * processing of the memory map data prior to ExitBootServices.  A client
  * specific structure may be passed to the function via priv.  The client
  * function may be called multiple times.
+ *
+ * Return:	status code
  */
 efi_status_t efi_exit_boot_services(void *handle,
 				    struct efi_boot_memmap *map,
@@ -361,6 +392,11 @@ efi_status_t efi_exit_boot_services(void *handle,
 	return status;
 }

+/**
+ * get_efi_config_table() - retrieve UEFI configuration table
+ * @guid:	GUID of the configuration table to be retrieved
+ * Return:	pointer to the configuration table or NULL
+ */
 void *get_efi_config_table(efi_guid_t guid)
 {
 	unsigned long tables =3D efi_table_attr(efi_system_table, tables);
@@ -408,17 +444,18 @@ static const struct {
 };

 /**
- * efi_load_initrd_dev_path - load the initrd from the Linux initrd devic=
e path
+ * efi_load_initrd_dev_path() - load the initrd from the Linux initrd dev=
ice path
  * @load_addr:	pointer to store the address where the initrd was loaded
  * @load_size:	pointer to store the size of the loaded initrd
  * @max:	upper limit for the initrd memory allocation
- * @return:	%EFI_SUCCESS if the initrd was loaded successfully, in which
- *		case @load_addr and @load_size are assigned accordingly
- *		%EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
- *		device path
- *		%EFI_INVALID_PARAMETER if load_addr =3D=3D NULL or load_size =3D=3D N=
ULL
- *		%EFI_OUT_OF_RESOURCES if memory allocation failed
- *		%EFI_LOAD_ERROR in all other cases
+ *
+ * Return:
+ * * %EFI_SUCCESS if the initrd was loaded successfully, in which
+ *   case @load_addr and @load_size are assigned accordingly
+ * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device =
path
+ * * %EFI_INVALID_PARAMETER if load_addr =3D=3D NULL or load_size =3D=3D =
NULL
+ * * %EFI_OUT_OF_RESOURCES if memory allocation failed
+ * * %EFI_LOAD_ERROR in all other cases
  */
 static
 efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
@@ -481,6 +518,16 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image=
_t *image,
 				    load_addr, load_size);
 }

+/**
+ * efi_load_initrd() - Load initial RAM disk
+ * @image:	EFI loaded image protocol
+ * @load_addr:	pointer to loaded initrd
+ * @load_size:	size of loaded initrd
+ * @soft_limit:	preferred size of allocated memory for loading the initrd
+ * @hard_limit:	minimum size of allocated memory
+ *
+ * Return:	status code
+ */
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
@@ -505,6 +552,15 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *imag=
e,
 	return status;
 }

+/**
+ * efi_wait_for_key() - Wait for key stroke
+ * @usec:	number of microseconds to wait for key stroke
+ * @key:	key entered
+ *
+ * Wait for up to @usec microseconds for a key stroke.
+ *
+ * Return:	status code, EFI_SUCCESS if key received
+ */
 efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key)
 {
 	efi_event_t events[2], timer;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi=
/libstub/efistub.h
index bcd8c0a785f0..ac756f1fdb1a 100644
=2D-- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -157,8 +157,14 @@ typedef void (__efiapi *efi_event_notify_t)(efi_event=
_t, void *);
 #define EFI_EVT_NOTIFY_WAIT	0x00000100U
 #define EFI_EVT_NOTIFY_SIGNAL	0x00000200U

-/*
- * boottime->wait_for_event takes an array of events as input.
+/**
+ * efi_set_event_at() - add event to events array
+ *
+ * @events:	array of UEFI events
+ * @ids:	index where to put the event in the array
+ * @event:	event to add to the aray
+ *
+ * boottime->wait_for_event() takes an array of events as input.
  * Provide a helper to set it up correctly for mixed mode.
  */
 static inline
=2D-
2.27.0

