Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274D042BC26
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhJMJyD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 05:54:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbhJMJyC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Oct 2021 05:54:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC182222D5;
        Wed, 13 Oct 2021 09:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634118718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA9BDJcI5fQpUiH9skGe8D3QbL5rS02Lw+A2yhWbX2Y=;
        b=TR915s66BXRg5uB/lrJCG5QRbnBPFxSaA2HsgytBatEFFqH649C23oNr9WKH1GsoJK463c
        v8moP06J46uM4R1VC1HhZiSoxmymJX6tmb9UqCbkKErEgt/xNsrz3g78/9KUgSHw/3N+m3
        pnu6cKX8xgrC5DVu9jZWMXbnSZrxvBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634118718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA9BDJcI5fQpUiH9skGe8D3QbL5rS02Lw+A2yhWbX2Y=;
        b=vAGMi8xH6OJACTYjZK3R6EGaICaIctCAeB18LuiE7CbbE2F+UyxUu9rkDyToUC1aFVWfje
        HiAORuKLqDKqUEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B931F13CEC;
        Wed, 13 Oct 2021 09:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3SIYKz6sZmH0OQAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 13 Oct 2021 09:51:58 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RESEND] [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL
 output as bootloader randomness"
From:   "Ivan T. Ivanov" <iivanov@suse.de>
In-Reply-To: <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
Date:   Wed, 13 Oct 2021 12:51:57 +0300
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E0472BF-BC05-4722-83EC-26919278CC2E@suse.de>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <4eccf707f2553f0f66ae3789b5689231@suse.de>
 <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

> On 13 Oct 2021, at 10:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Wed, 13 Oct 2021 at 09:30, Ivan T. Ivanov <iivanov@suse.de> wrote:
>>=20
>> Hi,
>>=20
>> Quoting Dominik Brodowski (2021-10-12 11:40:34)
>>> Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
>>>> This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
>>>>=20
>>>> When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled =
add_bootloader_randomness()
>>>> calls add_hwgenerator_randomness() which might sleep,
>>>=20
>>> Wouldn't it be better to fix add_bootloader_randomness(), =
considering
>>> that
>>> calls to that function are likely to happen quite early during =
kernel
>>> initialization? Especially as it seems to have worked beforehand?
>>=20
>> I have tried. I made wait_event_interruptible() optional, but then
>> crng_reseed() segfault badly. And I don't think crng_reseed() is
>> something that I could fix easily. Suggestions are welcomed ;-)
>>=20
>=20
> How about
>=20
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 605969ed0f96..1828dc691ebf 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2297,9 +2297,8 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>  */
> void add_bootloader_randomness(const void *buf, unsigned int size)
> {
> +       add_device_randomness(buf, size);
>        if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> -               add_hwgenerator_randomness(buf, size, size * 8);
> -       else
> -               add_device_randomness(buf, size);
> +               credit_entropy(&input_pool, size * 8);
> }
> EXPORT_SYMBOL_GPL(add_bootloader_randomness);

This doesn=E2=80=99t boot. I just changed following and kernel panics. =20=


- credit_entropy
+ credit_entropy_bits

Please see attached file.

Regards,
Ivan



