Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83525BE5BD
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiITM2F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiITM2E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 08:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C7E75391
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 05:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D5662055
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 12:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FDBC433D7;
        Tue, 20 Sep 2022 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663676881;
        bh=DZRyGE7/rIGWTDjMSq22KgTGDkZuurYQy+zWFRn5e9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qH8NcIj8Xp+HyOtitIG9c3DdkXhrca/CdPL3SZpIrrqWIQU22PbgeKWgF75X9pItS
         GyIklWyf8YR829nSoky2qV8N7xcZEiMh4VpVUNV6Z8KtRXS+aLQITEjswJhZTa/LvK
         vbi6+S/pTKgsUNavUtBfLcRDrluMK6TwY96cQkaaNpwtZh278yZWRQZ1Efr3mcicAN
         qlZwCyyp2mzJyMrsuJ1h8quvmmwkethIaNPmVfXnFOQr0YQAXUTBk0BXxwmv/NKZxh
         gQEyzmeBbpu7e42mI29Jaf29CcCTNLMpIWnR9eeZMA73A/udiujjDxpbqqxGkzLEY2
         xzvzhaTPH0QVQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Xu, Min M" <min.m.xu@intel.com>
Subject: [PATCH v2 1/2] efi/libstub: refactor the initrd measuring functions
Date:   Tue, 20 Sep 2022 14:27:45 +0200
Message-Id: <20220920122746.3553306-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920122746.3553306-1-ardb@kernel.org>
References: <20220920122746.3553306-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5459; i=ardb@kernel.org; h=from:subject; bh=srQKs7p3PC5iOf/ljqR6rUVwt+Y767+YpdciVWnF3DM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKbG/eAkKO02pkR+1khnWorCaal7avQCWzQVYXACi YjMXmsWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYymxvwAKCRDDTyI5ktmPJD/PDA CqsKNJIkIuUZbjs5A/Slc6JlfloYTx4TuqxIp4kFWmF3BUrG7J9HbEzOPlk72tV8e72SNM0/fl871/ Zl+V75GPAwHbs3c0ZahoZg4/OVXQqirvG811vBSROT8LmwkFG0wFkdi/xDVIB5eMi3EXMCAGsp+BbY jxr9mtx+GaHrVNvxfuVwyV+OS7CDcfbW8Ea/TXjUiEcV8+MDqkNTPoTTOD7m8bHm03iXYcRsiYsPyx mdxiPLerZ+BQuXRdn2juqT8p6rh+Jk64o3h8LJGSnycwUOWIe7B7kdYMKQuauxHhJg9DsIGK4Xzs6H MGXi8FLoS4HiR3eg3AgABF9zScsFE9SSmEDx3X56cw6VxkaXFBbvehXIpvFls0CjWyBr03Q4WZ3C0Z Qb5LIJ2Q0rISe7m08I/KxE4Uz7F0XYvL3H+cglCSXM+Kf1Ifx6QHaqR6sdBDZwk0ZC74wDzApOIxwX /ZD9BaG382S8az43Nz+Jl9s2pVwIjD0blaDD5d0adzl7U=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Currently, from the efi-stub, we are only measuring the loaded initrd,
using the TCG2 measured boot protocols.  A following patch is
introducing measurements of additional components, such as the kernel
command line. On top of that, we will shortly have to support other
types of measured boot that don't expose the TCG2 protocols.

So let's prepare for that, by rejigging the efi_measure_initrd() routine
into something that we should be able to reuse for measuring other
assets, and which can be extended later to support other measured boot
protocols.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 120 +++++++++++++-------
 1 file changed, 77 insertions(+), 43 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 829f732c5f37..8f9a79bc4e8e 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -334,6 +334,79 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
 	*load_options_size = load_option_unpacked.optional_data_size;
 }
 
+enum efistub_event {
+	EFISTUB_EVT_INITRD,
+	EFISTUB_EVT_COUNT,
+};
+
+#define STR_WITH_SIZE(s)	sizeof(s), s
+
+static const struct {
+	u32		pcr_index;
+	u32		event_id;
+	u32		event_data_len;
+	u8		event_data[52];
+} events[] = {
+	[EFISTUB_EVT_INITRD] = {
+		9,
+		INITRD_EVENT_TAG_ID,
+		STR_WITH_SIZE("Linux initrd")
+	},
+};
+
+static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
+					     unsigned long load_size,
+					     enum efistub_event event)
+{
+	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
+	efi_tcg2_protocol_t *tcg2 = NULL;
+	efi_status_t status;
+
+	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
+	if (tcg2) {
+		struct efi_measured_event {
+			efi_tcg2_event_t	event_data;
+			efi_tcg2_tagged_event_t tagged_event;
+			u8			tagged_event_data[];
+		} *evt;
+		int size = sizeof(*evt) + events[event].event_data_len;
+
+		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+				     (void **)&evt);
+		if (status != EFI_SUCCESS)
+			goto fail;
+
+		evt->event_data = (struct efi_tcg2_event){
+			.event_size			= size,
+			.event_header.header_size	= sizeof(evt->event_data.event_header),
+			.event_header.header_version	= EFI_TCG2_EVENT_HEADER_VERSION,
+			.event_header.pcr_index		= events[event].pcr_index,
+			.event_header.event_type	= EV_EVENT_TAG,
+		};
+
+		evt->tagged_event = (struct efi_tcg2_tagged_event){
+			.tagged_event_id		= events[event].event_id,
+			.tagged_event_data_size		= events[event].event_data_len,
+		};
+
+		memcpy(evt->tagged_event_data, events[event].event_data,
+		       events[event].event_data_len);
+
+		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
+					load_addr, load_size, &evt->event_data);
+		efi_bs_call(free_pool, evt);
+
+		if (status != EFI_SUCCESS)
+			goto fail;
+		return EFI_SUCCESS;
+	}
+
+	return EFI_UNSUPPORTED;
+fail:
+	efi_warn("Failed to measure data for event %d: 0x%lx\n", event, status);
+	return status;
+}
+
 /*
  * Convert the unicode UEFI command line to ASCII to pass to kernel.
  * Size of memory allocated return in *cmd_line_len.
@@ -626,47 +699,6 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				    load_addr, load_size);
 }
 
-static const struct {
-	efi_tcg2_event_t	event_data;
-	efi_tcg2_tagged_event_t tagged_event;
-	u8			tagged_event_data[];
-} initrd_tcg2_event = {
-	{
-		sizeof(initrd_tcg2_event) + sizeof("Linux initrd"),
-		{
-			sizeof(initrd_tcg2_event.event_data.event_header),
-			EFI_TCG2_EVENT_HEADER_VERSION,
-			9,
-			EV_EVENT_TAG,
-		},
-	},
-	{
-		INITRD_EVENT_TAG_ID,
-		sizeof("Linux initrd"),
-	},
-	{ "Linux initrd" },
-};
-
-static void efi_measure_initrd(unsigned long load_addr, unsigned long load_size)
-{
-	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
-	efi_tcg2_protocol_t *tcg2 = NULL;
-	efi_status_t status;
-
-	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
-	if (tcg2) {
-		status = efi_call_proto(tcg2, hash_log_extend_event,
-					0, load_addr, load_size,
-					&initrd_tcg2_event.event_data);
-		if (status != EFI_SUCCESS)
-			efi_warn("Failed to measure initrd data: 0x%lx\n",
-				 status);
-		else
-			efi_info("Measured initrd data into PCR %d\n",
-				 initrd_tcg2_event.event_data.event_header.pcr_index);
-	}
-}
-
 /**
  * efi_load_initrd() - Load initial RAM disk
  * @image:	EFI loaded image protocol
@@ -692,8 +724,10 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 		status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
 		if (status == EFI_SUCCESS) {
 			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-			if (*load_size > 0)
-				efi_measure_initrd(*load_addr, *load_size);
+			if (*load_size > 0 &&
+			    efi_measure_tagged_event(*load_addr, *load_size,
+						     EFISTUB_EVT_INITRD) == EFI_SUCCESS)
+				efi_info("Measured initrd data into PCR 9\n");
 		} else if (status == EFI_NOT_FOUND) {
 			status = efi_load_initrd_cmdline(image, load_addr, load_size,
 							 soft_limit, hard_limit);
-- 
2.35.1

