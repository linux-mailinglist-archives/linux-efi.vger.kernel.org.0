Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C621C45EA
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgEDS3o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 14:29:44 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:33792 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730292AbgEDS3n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 14:29:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BCBAE180050EA;
        Mon,  4 May 2020 18:29:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:4321:4385:4605:5007:7903:8603:10004:10400:10848:11026:11657:11658:11914:12043:12296:12297:12438:12555:12760:13439:14096:14097:14181:14659:14721:21080:21433:21627:21990:30054:30060:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: care86_8eb3f26475931
X-Filterd-Recvd-Size: 3895
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 18:29:40 +0000 (UTC)
Message-ID: <f1926d434cdeb091405ef8c01a90c0140d296bed.camel@perches.com>
Subject: [trivial PATCH] efi/libstub: Reduce efi_printk object size
From:   Joe Perches <joe@perches.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Mon, 04 May 2020 11:29:39 -0700
In-Reply-To: <CAMj1kXHwdy3BTqt-q_qnezyz666BcqKiFxeumfsD+Qjy5qRzZA@mail.gmail.com>
References: <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
         <ec53e67b3ac928922807db3cb1585e911971dadc.1588273612.git.joe@perches.com>
         <CAMj1kXHwdy3BTqt-q_qnezyz666BcqKiFxeumfsD+Qjy5qRzZA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use a few more common kernel styles.

Trivially reduce efi_printk object size by using a dereference to
a temporary instead of multiple dereferences of the same object.

Use efi_printk(const char *str) and static or static const for its
internal variables.

Use the more common form of while instead of a for loop.

Change efi_char16_printk argument to const.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 16 ++++++++--------
 drivers/firmware/efi/libstub/efistub.h         |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1c92ac231f94..dfd72a4360ac 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -26,19 +26,19 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
-void efi_printk(char *str)
+void efi_printk(const char *str)
 {
-	char *s8;
+	char s8;
 
-	for (s8 = str; *s8; s8++) {
-		efi_char16_t ch[2] = { 0 };
+	while ((s8 = *str++)) {
+		static efi_char16_t ch[2] = {0, 0};
 
-		ch[0] = *s8;
-		if (*s8 == '\n') {
-			efi_char16_t nl[2] = { '\r', 0 };
+		if (s8 == '\n') {
+			static const efi_char16_t nl[2] = { '\r', 0 };
 			efi_char16_printk(nl);
 		}
 
+		ch[0] = s8;
 		efi_char16_printk(ch);
 	}
 }
@@ -284,7 +284,7 @@ void *get_efi_config_table(efi_guid_t guid)
 	return NULL;
 }
 
-void efi_char16_printk(efi_char16_t *str)
+void efi_char16_printk(const efi_char16_t *str)
 {
 	efi_call_proto(efi_table_attr(efi_system_table, con_out),
 		       output_string, str);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 5ff63230a1f1..a03a92c665f0 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -251,7 +251,7 @@ union efi_simple_text_output_protocol {
 	struct {
 		void *reset;
 		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
-						       efi_char16_t *);
+						       const efi_char16_t *);
 		void *test_string;
 	};
 	struct {
@@ -599,7 +599,7 @@ efi_status_t efi_exit_boot_services(void *handle,
 				    void *priv,
 				    efi_exit_boot_map_processing priv_func);
 
-void efi_char16_printk(efi_char16_t *);
+void efi_char16_printk(const efi_char16_t *str);
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
@@ -624,7 +624,7 @@ efi_status_t check_platform_features(void);
 
 void *get_efi_config_table(efi_guid_t guid);
 
-void efi_printk(char *str);
+void efi_printk(const char *str);
 
 void efi_free(unsigned long size, unsigned long addr);
 

