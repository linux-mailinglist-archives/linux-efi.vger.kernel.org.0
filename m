Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA09A8413
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2019 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfIDNCY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Sep 2019 09:02:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51460 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbfIDNCY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Sep 2019 09:02:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so3235714wmi.1
        for <linux-efi@vger.kernel.org>; Wed, 04 Sep 2019 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYc/WH2seI0xG53pu04DpOsVrDgCeSJvzPVy1Wb7xbc=;
        b=OpobEe6f+1X770rq3d1rRf53pMVcgDaDEKe/WovlDp2hG/tqPnfNk5zQL1yR5IXJYF
         1MOTewq98YCQHq/Qu51mnCqQgtFbvHRRrMZ1+RGH0XfLfY6vCw6Dlf98UjtK/a+kDkuk
         nNsbIV8a1uNN66skhbYXIn4MVV0MeZM/TnE/j0BzdJTkbG0Nzg0kOh4ZJUZQtOh7vC/h
         bIEWGp3OWkoRDE2kZoGRRjicvsFXw0aeLn0495+eVPjpkaUDvVQNEfgQ3uSgctfx0TPl
         D8364k+W38v403LkqfHJzbpKJHFHRtkk4JMoBJI0YcJJFrX68HXQqL7xURr3fLiOJNV9
         6UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYc/WH2seI0xG53pu04DpOsVrDgCeSJvzPVy1Wb7xbc=;
        b=YRbwyG8G/1vAqRob2gxVUvrisme004cea8lJ+z/NvmdU7eoQQ8/gjIL1MgE/wZDw9C
         NqSaiIdKk7sZax0P79LeHW88Mc1p7YM8+ULMdKeD8ct9usEB06SvuGAybpb8KMvvNmdT
         mmuhmqSRJiUbtpg3MYxIZjQpx+V4FCIM3EGHE3de8eJnDdikfig7wvbfP68enkyEPKvw
         xrESMWxtdGcVocYNb9a+rAOyO3U52PlDs50t4pgVz/pcedzqm6cmdJEvcLaH9VnrN45d
         LYKVveAmmqTb8SMpGWuO26VdK6a1BCuuSiSm+PYUwuJCj+GFFeyx7gHErC7s5cA+Eig/
         ANKw==
X-Gm-Message-State: APjAAAXef7ObcNLL36Tvy3zDU5CQcrcTFpjNxuGUMeIF7xksiVp6sTbL
        pBbEcfeDEJ6vRZPEg85tVMxic4gZQz9xEl4Po9eJLA==
X-Google-Smtp-Source: APXvYqyCgK6btzLgwwnSgv74jEoWQoHI8ozi7jcw7cQUQdxzdOcrwHxKh0kRXd8ctiQN4glkzmopK4ioCeAsyCa3ItY=
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr4129045wma.119.1567602141735;
 Wed, 04 Sep 2019 06:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190901203532.2615-1-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Sep 2019 06:02:09 -0700
Message-ID: <CAKv+Gu8zQd982BH=WRzJC_acU5d+JR2vYzwm9cs4Zrp5Y3FzrQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] crypto: sha256 - Merge crypto/sha256.h into crypto/sha.h
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 1 Sep 2019 at 13:35, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> As promised here is a follow-up series to my earlier sha256 series.
>
> Note I have only compiled and tested this series on x86_64 !!
>
> All changes to architecture specific code on other archs have not even
> been tested to compile! With that said most of these changes were done
> using my editors search - replace function so things should be fine...
> (and FWIW I did do a Kconfig hack to compile test the ccree change).
>
> The first patch in this series rename various file local functions /
> arrays to avoid conflicts with the new include/crypto/sha256.h, followed
> by a patch merging include/crypto/sha256.h into include/crypto/sha.h.
>
> The last patch makes use of this merging to remove a bit more code
> duplication, making sha256_generic use sha256_init and sha224_init from
> lib/crypto/sha256.c. An added advantage of this, is that this gives these
> 2 functions coverage by the crypto selftests.
>

For the series,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks Hans.
