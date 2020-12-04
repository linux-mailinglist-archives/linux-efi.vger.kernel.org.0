Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391E12CF372
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgLDR5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 12:57:42 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:57236 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDR5m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Dec 2020 12:57:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EFE5C12806D3;
        Fri,  4 Dec 2020 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607104620;
        bh=j/eiQ9XC4YVyXHPaGvnixXqre38vTxKbe7IysEXG/gQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LJv6d585fMMbsbl72vwxEil6yGk8n+dpPg0+K0c9QGLI6z2Tnb35IajlkkZ/poYVt
         Apwk3JR5UaJjDvC46VLJvsCb+SFQ5eqvWGVnU98pT0RQI8tTzpuqlku09Jz0OireDV
         CvQHnAFrsu77RWt/AkDGWfrret+uJBj5l78JAyzI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id INp-1Jb0T2J6; Fri,  4 Dec 2020 09:57:00 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 92AB012806D2;
        Fri,  4 Dec 2020 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607104620;
        bh=j/eiQ9XC4YVyXHPaGvnixXqre38vTxKbe7IysEXG/gQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LJv6d585fMMbsbl72vwxEil6yGk8n+dpPg0+K0c9QGLI6z2Tnb35IajlkkZ/poYVt
         Apwk3JR5UaJjDvC46VLJvsCb+SFQ5eqvWGVnU98pT0RQI8tTzpuqlku09Jz0OireDV
         CvQHnAFrsu77RWt/AkDGWfrret+uJBj5l78JAyzI=
Message-ID: <d706cdbcc4eba3fb3fe17453017a6623f1ec80dc.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v1 00/12] Replace strstarts() by str_has_prefix()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     laniel_francis@privacyrequired.com,
        Russell King <linux@armlinux.org.uk>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Fri, 04 Dec 2020 09:56:58 -0800
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-12-04 at 18:03 +0100, laniel_francis@privacyrequired.com
wrote:
> In this patch set, I replaced all calls to strstarts() by calls to
> str_has_prefix(). Indeed, the kernel has two functions to test if a
> string begins with an other:
> 1. strstarts() which returns a bool, so 1 if the string begins with
> the prefix,0 otherwise.
> 2. str_has_prefix() which returns the length of the prefix or 0.
> 
> str_has_prefix() was introduced later than strstarts(), in commit
> 495d714ad140 which also stated that str_has_prefix() should replace
> strstarts(). This is what this patch set does.

What's the reason why?  If you look at the use cases for the
replacement of strstart()  they're all cases where we need to know the
length we're skipping and this is hard coded, leading to potential
errors later.  This is a classic example:  3d739c1f6156 ("tracing: Use
the return of str_has_prefix() to remove open coded numbers").  However
you're not doing this transformation in the conversion, so the
conversion is pretty useless.  I also see no case for replacing
strstart() where we're using it simply as a boolean without needing to
know the length of the prefix.

James


