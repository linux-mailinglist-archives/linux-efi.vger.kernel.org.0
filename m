Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7E647C15
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 03:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLICPo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Dec 2022 21:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLICPn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Dec 2022 21:15:43 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42FE66C84;
        Thu,  8 Dec 2022 18:15:42 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5A11A5C0787;
        Fri,  9 Dec 2022 02:09:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C3CC55C19B2;
        Fri,  9 Dec 2022 02:09:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670551761; a=rsa-sha256;
        cv=none;
        b=DSqcruP0iM4LEk6bxAFfT8cu2PnWwmo9xhZ5igtbj9Vue2iORjFq/yQ3giPe4u5Xxquoo0
        VK0CT3Uv8Lwu2yPzoqxcfBSeTiaPXMJTx9xcOLWKLhaUryAoKrzV28fY2OPlhoyHI3KzKx
        62sarE4egV+hipr1wssM6f9dknozrFg9bOOrbuADLw3txzJduLqqlTk4FbejRY0TtyZlLa
        LY3afqVq29KhZEm1/ysPBA368tdnAeY3WBY/G84F1b3qL7w6BAVypeVZgBHd9vcrMol0zc
        Ygt4wufOvx3kYGGLe4oMF3NToaiAU0Hz5OCEqe6tTAfH8qH8M6Y/Q/wJFIreRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670551761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6noX/pnBcWcHX05sCpu8cyyts9NTKcpFhxpqcG6qCOg=;
        b=rYapv9ydWUckAPFj4jibFbhRNIfDpea8jArVw3nV7DNHel/7cWrKcy8fOiVgCLKGaDR68/
        E9b4RRQUyZFa3cH2JoL09XJFz8Xb7H3+1rGH7mw7GRmUuvGsZ0w11fJYOgSPdmXd7ZoxcZ
        RuBXrEa56+2bJpA9JT6EEzr6LqUC9SaYAgICfSaJlywGLJQykK3yRYeCswGvcIskRdKcud
        pdPGCD/zXgVV8kgibuv02Tw4WJmx5/g5D4/5Y9RxQQ608synIO32GA6FdwZj3jG+pbE1/c
        89rnrdwyb09jaw8kNryWh/5U3Pd9ExWwgXc4JDR0hPcJIbQOEpoXN3zMXEVyhg==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-jbg4j;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Average: 7cb0e6be76423bd7_1670551762160_2362704701
X-MC-Loop-Signature: 1670551762160:2444031178
X-MC-Ingress-Time: 1670551762160
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.72 (trex/6.7.1);
        Fri, 09 Dec 2022 02:09:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4NSvbN5Nt6z99;
        Thu,  8 Dec 2022 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670551761;
        bh=6noX/pnBcWcHX05sCpu8cyyts9NTKcpFhxpqcG6qCOg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=cjGKxJNqa+x3imp2jpO+DHkU+9YuJJtPJ8T5QpA9kygsk8T7ZD8IFQoQc3LR/QZop
         P61yve9tdGud1C5NYdH1r3+lC78E5KdC/bxjGplQq4GFpZa7Rcw1xQTOCRoF/KPCYk
         An3yz3vvAxsUFhgqFWeBhx3Z+9LMUmx7nGCUyzcHvKeBZPH1xERl2mDPrbFJzsq4zX
         1VpPRB1lNbgOO7iiCS+HdhR/hV+Komko9vtl7E6kue70YqsKaBJrQSe/Lzr2BljyZ2
         GUBKiRodd1H7ro9cR7XOSwIa5M5j/4hsPRLdb9lv46yc0lkl1rtUiY4S2lu9HAtSIS
         cmQ+NveY2H0aA==
Date:   Thu, 8 Dec 2022 17:45:12 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 3/5] partitions/efi: add support for uImage.FIT
 sub-partitions
Message-ID: <20221209014512.dos7666lkvmfhahs@offworld>
References: <Y2rgVIbtuDsySzBr@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2rgVIbtuDsySzBr@makrotopia.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 08 Nov 2022, Daniel Golle wrote:

>Add new GUID allowing to parse uImage.FIT stored in a GPT partition
>and map filesystem sub-image as sub-partitions.
>
>Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>---
> block/partitions/efi.c | 9 +++++++++
> block/partitions/efi.h | 3 +++
> 2 files changed, 12 insertions(+)
>
>diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>index 5e9be13a56a8..bf87893eabe4 100644
>--- a/block/partitions/efi.c
>+++ b/block/partitions/efi.c
>@@ -716,6 +716,9 @@ int efi_partition(struct parsed_partitions *state)
>	gpt_entry *ptes = NULL;
>	u32 i;
>	unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;
>+#ifdef CONFIG_FIT_PARTITION
>+	u32 extra_slot = 65;
>+#endif

You can move this in the branch below where you call parse_fit_partitions().

>
>	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
>		kfree(gpt);
>@@ -749,6 +752,12 @@ int efi_partition(struct parsed_partitions *state)
>				ARRAY_SIZE(ptes[i].partition_name));
>		utf16_le_to_7bit(ptes[i].partition_name, label_max, info->volname);
>		state->parts[i + 1].has_info = true;
>+		/* If this is a U-Boot FIT volume it may have subpartitions */
>+#ifdef CONFIG_FIT_PARTITION
>+		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_FIT_GUID))
>+			(void) parse_fit_partitions(state, start * ssz, size * ssz,
>+						    &extra_slot, 127, 1);
>+#endif
>	}
>	kfree(ptes);
>	kfree(gpt);
>diff --git a/block/partitions/efi.h b/block/partitions/efi.h
>index 84b9f36b9e47..06c11f6ae398 100644
>--- a/block/partitions/efi.h
>+++ b/block/partitions/efi.h
>@@ -51,6 +51,9 @@
> #define PARTITION_LINUX_LVM_GUID \
>     EFI_GUID( 0xe6d6d379, 0xf507, 0x44c2, \
>               0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28)
>+#define PARTITION_LINUX_FIT_GUID \
>+    EFI_GUID( 0xcae9be83, 0xb15f, 0x49cc, \
>+              0x86, 0x3f, 0x08, 0x1b, 0x74, 0x4a, 0x2d, 0x93)
>
> typedef struct _gpt_header {
>	__le64 signature;
>--
>2.38.1
>
