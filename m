Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7529BA633E
	for <lists+linux-efi@lfdr.de>; Tue,  3 Sep 2019 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfICH7X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Sep 2019 03:59:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36692 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfICH7W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Sep 2019 03:59:22 -0400
Received: by mail-vs1-f68.google.com with SMTP id r1so7885834vsq.3
        for <linux-efi@vger.kernel.org>; Tue, 03 Sep 2019 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0EIbhIJ7hKKOu+M281PD3WDdpKkR/xA5QEVwHRycTR0=;
        b=Lz8LMQhaTxdacgyadkkNlBcEe9tBTF6g2Stqiw+ggeQ7ZvzWzCXwwFaRgbu9gGjYIl
         lgs+jWRb+B//qn14IUPCm+BKxLLp6MDvUFnr48zd67gqoulkvMMMO7QSPs3Qkbd7v8P2
         JzYL1VGYv+8pWnDDfFUDPiWQQkJiYEnRnCJaSBagiDgg9QOVn4SMhr8aBCHZIfuaqxsA
         CNJLraj+UCdJwt91JZNtqo7j1SepslMoRtYWz4L1i680RXznMVpqYXudJKJl0rieosxa
         hHtqI/xZz2533ni8GMtVguyDb49VMP0btKTr1dDiPWMatQC9ufxj7i/+rXCJRzbDPl7G
         McwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EIbhIJ7hKKOu+M281PD3WDdpKkR/xA5QEVwHRycTR0=;
        b=WQe6Ix2rMkcXl3diC8PcKmpHJ0wqFnxRgIhBe6Vj3s9RxKYS2iESFoRtbguvHSIioR
         rKJoCrT3ON+WxC8IvPDMEGpsWprYzFD0rgQnavEnzxyHkLG17csqdWiRPw2yKHoS2snZ
         yZGABA7OPrUCFux8iblURwwmym69/g3lZsn9+9Y/pez8o55tkJV3xCAe1zs5fEsPuC2L
         3IDt45dwhK8siB+LTaOKFnZmpgwGWTXbgHzrSusriGwBenByWBXXrzC+WqG8sPMDt+Ee
         WQ/8+IWRPn978MqxfVYIuhkYVBPE7u06rU967baUdKtDX/Ifl10OZR2idzb7vkLjYpOG
         pk0g==
X-Gm-Message-State: APjAAAVy1wXCOqqzLSuWMbwQ1/hMcYTxuwCaR8ncddDsWnbYL4fAZiBY
        xzXn2W9Zb690ormyP/3ugmweW2U2epDTe6yjs6TDpA==
X-Google-Smtp-Source: APXvYqzLbfk+7QC7rLnbvGPNJsbo//EE9HrvhMXGdOD64gG+wjNiviukUFKpbMwLXQphsPJJIcfQjKXRlkCVUjoLzNE=
X-Received: by 2002:a67:f546:: with SMTP id z6mr17083944vsn.136.1567497561775;
 Tue, 03 Sep 2019 00:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190901203532.2615-1-hdegoede@redhat.com> <20190901203532.2615-6-hdegoede@redhat.com>
 <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com> <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
In-Reply-To: <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 3 Sep 2019 10:59:10 +0300
Message-ID: <CAOtvUMeK2+29PJBm6L1S0dqM8JXEZYUy1qKiP9H=xDEJjnO7mA@mail.gmail.com>
Subject: Re: [PATCH 5/9] crypto: ccree - Rename arrays to avoid conflict with crypto/sha256.h
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
        Atul Gupta <atul.gupta@chelsio.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 3, 2019 at 10:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-09-19 09:45, Gilad Ben-Yossef wrote:
> > On Sun, Sep 1, 2019 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wro=
te:
> >>
> >> Rename the algo_init arrays to cc_algo_init so that they do not confli=
ct
> >> with the functions declared in crypto/sha256.h.
> >>
> >> This is a preparation patch for folding crypto/sha256.h into crypto/sh=
a.h.
> >
> > I'm fine with the renaming.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Your Signed-off-by is only used when the patches passes through your hand=
s,
> since Herbert will likely apply this directly that is not the case.
>
> You want either Acked-by or Reviewed-by to signal that you are ok with th=
is patch.
>

Yes, you are right of course. Wrong macro... sorry about that.

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
