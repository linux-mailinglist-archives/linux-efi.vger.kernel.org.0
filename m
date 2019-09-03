Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D937A62F3
	for <lists+linux-efi@lfdr.de>; Tue,  3 Sep 2019 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfICHpd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Sep 2019 03:45:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45849 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfICHpd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Sep 2019 03:45:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id j25so10621151vsq.12
        for <linux-efi@vger.kernel.org>; Tue, 03 Sep 2019 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFrdK23ABQ4OmIay3wgO+JPOpB+v5jDpV220cb1264Q=;
        b=ufwLEFaxFvvebslcyBbnlbc241i8XCEIlYE9wBiVJzjKucNO4eL1Na+LBUvtqz1FgL
         0nI9xN8fOYPappYKOskoqbaYYxhCb3PvLx9y4Wny7CjinopqfC0cv3EIvJ/tIXAhI4vz
         E2fyfXxycZQ1V9MaJ5KrZ8n//JHLSaT3S3mSjjxjsGU1LuBvEYlxEQyL5b/F3KVpIFiP
         N3NFsrY+79vToYlc7OsQuMRZr4xpv8JWicFnaCsy143PuOIncx321v5ZzrJHufsTr/CI
         BUGGU8MQvYhE3W+DRpd/1UQmERT3DAY8x7i5MtUQm23Ix019VfmAutO3WtSiyRx3lM8R
         mOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFrdK23ABQ4OmIay3wgO+JPOpB+v5jDpV220cb1264Q=;
        b=oppxo3JTa1dnn21Vr40pvjTkWZy+Al2/Gu639QzqypgH5Fs5+AfHRr/1joj8omH6Yg
         fO/Y6J/rktF433CQfhrEI7LoPvqUWbWQ/fILlZ8FKhv5EYI1Nr1CqrNuMAdg2boM0oTw
         Jcq+LdNodmLli+qGG1qond2hKuxjujfHQIWdY/UGNOVAybTvphwzN1tQh5BYlMVQ13pA
         XuEPaKXbOpPqu04YfBqkKwdMte1RMkH6CQNOk+mMJ1wC2M/mJF5gUFNjX3FjqZ93CzuQ
         JjmlwzP/qkVCy3Jhq7z67pt544pbE2Q/gH6zYSnih+8lq/gQOIJbFIxoZR2IgsHO4Sc7
         hmdA==
X-Gm-Message-State: APjAAAXe44wsNzK4mSIfFSB/5q0rrsHHRUOeq91Dz+7VM52BKT39sBVP
        uHEFXzSh3OIY6LEfneNj/J7nf49lLm5wqvkR1K++qg==
X-Google-Smtp-Source: APXvYqwbodlz7C9/rGshgIf7/qYpAxUq0gr6cTRVIP3xE0GyOpy2iRluovRfONJrQ0fD8bl9acvTKe0dYnil3LY22UY=
X-Received: by 2002:a67:e886:: with SMTP id x6mr9386146vsn.117.1567496732233;
 Tue, 03 Sep 2019 00:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190901203532.2615-1-hdegoede@redhat.com> <20190901203532.2615-6-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-6-hdegoede@redhat.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 3 Sep 2019 10:45:21 +0300
Message-ID: <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com>
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
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Sep 1, 2019 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Rename the algo_init arrays to cc_algo_init so that they do not conflict
> with the functions declared in crypto/sha256.h.
>
> This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

I'm fine with the renaming.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad
