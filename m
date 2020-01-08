Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB6134404
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgAHNj2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 08:39:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgAHNj1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 08:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=clEJSHFzJxXTF/L+L5nG3nazAWlUuBe7SRBk68jFd6s=; b=eOHK9Q8mtURBJ1nEoguBU3qKa
        ZnVSAnrg+EqlnzxvAjfSGzELcp+uZSRMg31svloblilttWFy1vMeY5F0IOyN1aUtOpMnnq2V6XmNt
        i98z3Tt9by8DN/Zm/QCgMRNbQruA/gxnYiy6BcXOJv1ym/nubqVxjHwJwh9FUAYgGB82hJ2eHuHn5
        SSG0Le+CU5/Rq/wAV07qadpuVni8SN2Z7vIlgWecghpt8diUZRzxVW9lpO0BIewrLZ95y8sBP8ZHo
        BPTN9iBHhC+36BP6Xfj04eQxoPvCDayHj7FuEnFZHsvVwF22MGETmfpqNIdDv/8mFP/IT5HVeMB2L
        Cb6qq4GoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBYU-0004Yn-Gk; Wed, 08 Jan 2020 13:39:26 +0000
Date:   Wed, 8 Jan 2020 05:39:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
        linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] partitions/efi: Fix partition name parsing in GUID
 partition entry
Message-ID: <20200108133926.GC4455@infradead.org>
References: <20181124162123.21300-1-n.merinov@inango-systems.com>
 <20191224092119.4581-1-n.merinov@inango-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224092119.4581-1-n.merinov@inango-systems.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> index db2fef7dfc47..51287a8a3bea 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -715,7 +715,7 @@ int efi_partition(struct parsed_partitions *state)
>  				ARRAY_SIZE(ptes[i].partition_name));
>  		info->volname[label_max] = 0;
>  		while (label_count < label_max) {
> -			u8 c = ptes[i].partition_name[label_count] & 0xff;
> +			u8 c = le16_to_cpu(ptes[i].partition_name[label_count]) & 0xff;
>  			if (c && !isprint(c))
>  				c = '!';
>
This adds an overly long line.  Please add a an efi_char_from_cpu or
similarly named helper to encapsulate this logic.

Otherwise the change looks good.

