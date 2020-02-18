Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1F162742
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 14:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRNlM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 08:41:12 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:55690 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBRNlM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Feb 2020 08:41:12 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 08:41:10 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 0842010807C2;
        Tue, 18 Feb 2020 15:34:36 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7hm_tDghVA1O; Tue, 18 Feb 2020 15:34:35 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 2FF9810807BD;
        Tue, 18 Feb 2020 15:34:35 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 2FF9810807BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1582032875;
        bh=BnLIe6sgQYUJrm3LGDhkAzwCf08EBK8HoDQzaBz3dbM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jSWjqqQylMIF6017ESekgGCGMmWr3d62l3xi8/WwRQZlhHkpb2gUhc3i8eDYPwpVZ
         TMy459ext8jfUY1WufwSbOPEsIpFLukncYnFKvlmVet2QK2u3s6RPmyQCUX9Fe0yOT
         VTYKR/T6lTYgfEmwbT6/GtexzVCO5gdjCF8nkVrsg33SX0SKWEiZmsaRhF6XI/r3z0
         I4W2HqAvLF1CuBixRc4Dj2g67lV3nul9ozqnqFCAB38tUFM623cvkIYZC82VmIPg1m
         G+oyu9KDAspC39+bcHQJzgxdu+BtYizKzcaITyQMZ5Zym4acJynA/yGL1xaSNPaacB
         Q7BVzfJeGjsyw==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4_YIkOoajecK; Tue, 18 Feb 2020 15:34:35 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
        by mail.inango-sw.com (Postfix) with ESMTP id 0A57210807B0;
        Tue, 18 Feb 2020 15:34:35 +0200 (IST)
Date:   Tue, 18 Feb 2020 15:34:34 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     hch@infradead.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2004778677.1182221.1582032874756.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
References: <20181124162123.21300-1-n.merinov@inango-systems.com> <20191224092119.4581-1-n.merinov@inango-systems.com> <20200108133926.GC4455@infradead.org> <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - GC79 (Linux)/8.8.15_GA_3890)
Thread-Topic: partitions/efi: Fix partition name parsing in GUID partition entry
Thread-Index: 9xpn1qrbCtCK5dkZiyC1ZLQoAz8IQA==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

Did you have a time to look at this patch? Should I make any modification? 

Regards,
Nikolai

----- Original Message -----
> From: "n merinov" <n.merinov@inango-systems.com>
> To: hch@infradead.org, "Davidlohr Bueso" <dave@stgolabs.net>, "Jens Axboe" <axboe@kernel.dk>, "Ard Biesheuvel"
> <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-block@vger.kernel.org, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Cc: "n merinov" <n.merinov@inango-systems.com>
> Sent: Monday, January 13, 2020 3:27:23 PM
> Subject: [PATCH v3] partitions/efi: Fix partition name parsing in GUID partition entry

> GUID partition entry defined to have a partition name as 36 UTF-16LE
> code units. This means that on big-endian platforms ASCII symbols
> would be read with 0xXX00 efi_char16_t character code. In order to
> correctly extract ASCII characters from a partition name field we
> should be converted from 16LE to CPU architecture.
> 
> The problem exists on all big endian platforms.
> 
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> ---
> block/partitions/efi.c | 3 ++-
> block/partitions/efi.h | 2 +-
> include/linux/efi.h    | 5 +++++
> 3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index db2fef7dfc47..f1d0820de844 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -715,7 +715,8 @@ int efi_partition(struct parsed_partitions *state)
> 				ARRAY_SIZE(ptes[i].partition_name));
> 		info->volname[label_max] = 0;
> 		while (label_count < label_max) {
> -			u8 c = ptes[i].partition_name[label_count] & 0xff;
> +			u8 c = 0xff & efi_char16le_to_cpu(
> +					ptes[i].partition_name[label_count]);
> 			if (c && !isprint(c))
> 				c = '!';
> 			info->volname[label_count] = c;
> diff --git a/block/partitions/efi.h b/block/partitions/efi.h
> index 3e8576157575..4d4cae0bb79e 100644
> --- a/block/partitions/efi.h
> +++ b/block/partitions/efi.h
> @@ -88,7 +88,7 @@ typedef struct _gpt_entry {
> 	__le64 starting_lba;
> 	__le64 ending_lba;
> 	gpt_entry_attributes attributes;
> -	efi_char16_t partition_name[72 / sizeof (efi_char16_t)];
> +	efi_char16le_t partition_name[72 / sizeof(efi_char16le_t)];
> } __packed gpt_entry;
> 
> typedef struct _gpt_mbr_record {
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index aa54586db7a5..47882f2d45db 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -45,9 +45,14 @@
> typedef unsigned long efi_status_t;
> typedef u8 efi_bool_t;
> typedef u16 efi_char16_t;		/* UNICODE character */
> +typedef __le16 efi_char16le_t;		/* UTF16-LE */
> +typedef __be16 efi_char16be_t;		/* UTF16-BE */
> typedef u64 efi_physical_addr_t;
> typedef void *efi_handle_t;
> 
> +#define efi_char16le_to_cpu le16_to_cpu
> +#define efi_char16be_to_cpu be16_to_cpu
> +
> /*
>  * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
>  * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> --
> 2.17.1
