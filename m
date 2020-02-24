Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69616ACAF
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBXRIT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 12:08:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBXRIT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 12:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RI4pNizaN/Qi/rAlgJxrBQWDqEZh68K0XdARYBgsCFs=; b=jYduAdnGRYYPQlZW9TslYS2O7V
        nzFnwPrCjyUubFLzDx+WDdhxRE7xCW1dXLBb8wKF85nsDjvc0+lDIndVb8YX/uDB22Ow/S08eMz2E
        k4GGN/gINDJy8qhaLzJo0ZMHlmDGIwgckFeKRTmZzqEkS98+IBTIT8wJz6K4kWkUUlYPl7jEgrIyK
        HzerGlkQDfR9lJPudGYmPvrZFjKUMBrJ5+IO1UtPif66/pUhr0h1dd0Eq10Zt95ga47eU8ZPK0yZ9
        3fy36JsB59IHAW37pNaXjdChsf8aEyN+46wEs2y9ppVSXo9Zq5KfmRoV3p4Ya3tYIQuyarmZUU9fR
        xuFkORVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6HDJ-0000Zi-KX; Mon, 24 Feb 2020 17:08:13 +0000
Date:   Mon, 24 Feb 2020 09:08:13 -0800
From:   hch <hch@infradead.org>
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     hch <hch@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
        Jens Axboe <axboe@kernel.dk>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
Message-ID: <20200224170813.GA27403@infradead.org>
References: <20181124162123.21300-1-n.merinov@inango-systems.com>
 <20191224092119.4581-1-n.merinov@inango-systems.com>
 <20200108133926.GC4455@infradead.org>
 <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
 <20200218185336.GA14242@infradead.org>
 <797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 24, 2020 at 01:38:39PM +0200, Nikolai Merinov wrote:
> Hi Christoph, 
> 
> > I'd rather use plain __le16 and le16_to_cpu here. Also the be 
> > variants seems to be entirely unused. 
> 
> Looks like I misunderstood your comment from https://patchwork.kernel.org/patch/11309223/: 
> 
> > Please add a an efi_char_from_cpu or similarly named helper 
> > to encapsulate this logic. 
> 
> The "le16_to_cpu(ptes[i].partition_name[label_count])" call is the 
> full implementation of the "efi_char_from_cpu" logic. Do you want 
> to encapsulate "utf16_le_to_7bit_string" logic entirely like in
> the attached version?

I think I though of just the inner loop, but your new version looks even
better, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
