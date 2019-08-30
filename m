Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305DEA3243
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2019 10:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfH3IZq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Aug 2019 04:25:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59720 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfH3IZp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Aug 2019 04:25:45 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i3cDa-0005jJ-Mk; Fri, 30 Aug 2019 18:25:15 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Aug 2019 18:25:08 +1000
Date:   Fri, 30 Aug 2019 18:25:08 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sha256 - Add missing MODULE_LICENSE() to
 lib/crypto/sha256.c
Message-ID: <20190830082508.GI8033@gondor.apana.org.au>
References: <20190825181841.2494-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825181841.2494-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Aug 25, 2019 at 08:18:41PM +0200, Hans de Goede wrote:
> lib/crypto/sha256.c / lib/crypto/libsha256.o may end up being a module,
> so it needs a MODULE_LICENSE() line, add this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  lib/crypto/sha256.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
