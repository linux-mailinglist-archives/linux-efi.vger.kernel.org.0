Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79C7162F0F
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 19:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRSxk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 13:53:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRSxk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Feb 2020 13:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6j4dbVJFJ7oC5DhQZUAIAKi7jxQSaytsVxqOSb9w4KQ=; b=U2j547CyaTMSl1ZbRusn62lgFo
        J84flzxCZ4FHWDTcaPQ1AXHDxrJ4x9KkJ4LkWBgafCFjPC1U5sTuP2Xga8daT30nhifZiBXhNOkGa
        nL27PfE/VPWQjKFtFMEWNa2HvzjkyCFuFi0AohXmC6XOGhRfjc+QP3NVjvuRmrJUOKkB6xsgDcLN6
        Tm1XDKozCfBPbzoqOqd8YPIMQjf1OdhXTZ/hOY7UA47vOkuseO4GfUb4lTd18nx2XKopkgHIxUsYV
        aQN4ihIQzpNNZwDK+rVq1IToXO1awP5GMc1SVbK95/HKgB2pn4ACNF2ijCKTa5bNuZOGmNp9sVzLw
        aizBuPiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4800-0007Am-Hw; Tue, 18 Feb 2020 18:53:36 +0000
Date:   Tue, 18 Feb 2020 10:53:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     hch@infradead.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
Message-ID: <20200218185336.GA14242@infradead.org>
References: <20181124162123.21300-1-n.merinov@inango-systems.com>
 <20191224092119.4581-1-n.merinov@inango-systems.com>
 <20200108133926.GC4455@infradead.org>
 <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 13, 2020 at 03:27:23PM +0500, Nikolai Merinov wrote:
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
>  block/partitions/efi.c | 3 ++-
>  block/partitions/efi.h | 2 +-
>  include/linux/efi.h    | 5 +++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index db2fef7dfc47..f1d0820de844 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -715,7 +715,8 @@ int efi_partition(struct parsed_partitions *state)
>  				ARRAY_SIZE(ptes[i].partition_name));
>  		info->volname[label_max] = 0;
>  		while (label_count < label_max) {
> -			u8 c = ptes[i].partition_name[label_count] & 0xff;
> +			u8 c = 0xff & efi_char16le_to_cpu(
> +					ptes[i].partition_name[label_count]);

Why are you swapping the order of the comparism to an unusual one here?

> -	efi_char16_t partition_name[72 / sizeof (efi_char16_t)];
> +	efi_char16le_t partition_name[72 / sizeof(efi_char16le_t)];
>  } __packed gpt_entry;
>  
>  typedef struct _gpt_mbr_record {
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index aa54586db7a5..47882f2d45db 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -45,9 +45,14 @@
>  typedef unsigned long efi_status_t;
>  typedef u8 efi_bool_t;
>  typedef u16 efi_char16_t;		/* UNICODE character */
> +typedef __le16 efi_char16le_t;		/* UTF16-LE */
> +typedef __be16 efi_char16be_t;		/* UTF16-BE */
>  typedef u64 efi_physical_addr_t;
>  typedef void *efi_handle_t;
>  
> +#define efi_char16le_to_cpu le16_to_cpu
> +#define efi_char16be_to_cpu be16_to_cpu

I'd rather use plain __le16 and le16_to_cpu here.  Also the be
variants seems to be entirely unused.
