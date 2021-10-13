Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14442B9DC
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhJMIHn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 04:07:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56158 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhJMIHn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Oct 2021 04:07:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 563EC2228E;
        Wed, 13 Oct 2021 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634112339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MYBetIHiRnm5MPnYrU8m+s3sHrngXKaFc0Qug9OrkIs=;
        b=EjAzsDX2+zKTYfvf6tt1UnI74JTcYBLgT6njvzgUQGlmGCeEoRsvOeuV7f5wF7ORhcCLiM
        YJvYbI+0sv2xyxT5A73pPpWj/dPiRc9XmnRlf8tI/avsJgwb1JxVSqM3XfKddXE1mII69t
        jVbKFicq5fCtiYhBL9UWMEQcmAZWFzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634112339;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MYBetIHiRnm5MPnYrU8m+s3sHrngXKaFc0Qug9OrkIs=;
        b=uZAM7JtAcnRqCt2eGdlCK12fNcC034xOtUV5YyFXRy8Ra/5d9IJbFjVzxbNBrCqwdhiAQB
        9VHc+iHjgaF8VFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CEB213CBE;
        Wed, 13 Oct 2021 08:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X5uUElOTZmEvBgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 13 Oct 2021 08:05:39 +0000
MIME-Version: 1.0
Date:   Wed, 13 Oct 2021 11:05:39 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Re: [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL
 output as bootloader randomness"
In-Reply-To: <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <4eccf707f2553f0f66ae3789b5689231@suse.de>
 <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <e8c2ce11ec8b6193d891288ce6b3caa0@suse.de>
X-Sender: iivanov@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-10-13 10:50, Ard Biesheuvel wrote:
> On Wed, 13 Oct 2021 at 09:30, Ivan T. Ivanov <iivanov@suse.de> wrote:
>> 
>> Hi,
>> 
>> Quoting Dominik Brodowski (2021-10-12 11:40:34)
>> > Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
>> > > This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
>> > >
>> > > When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled add_bootloader_randomness()
>> > > calls add_hwgenerator_randomness() which might sleep,
>> >
>> > Wouldn't it be better to fix add_bootloader_randomness(), considering
>> > that
>> > calls to that function are likely to happen quite early during kernel
>> > initialization? Especially as it seems to have worked beforehand?
>> 
>> I have tried. I made wait_event_interruptible() optional, but then
>> crng_reseed() segfault badly. And I don't think crng_reseed() is
>> something that I could fix easily. Suggestions are welcomed ;-)
>> 
> 
> How about
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 605969ed0f96..1828dc691ebf 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2297,9 +2297,8 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>   */
>  void add_bootloader_randomness(const void *buf, unsigned int size)
>  {
> +       add_device_randomness(buf, size);
>         if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> -               add_hwgenerator_randomness(buf, size, size * 8);
> -       else
> -               add_device_randomness(buf, size);
> +               credit_entropy(&input_pool, size * 8);
>  }
>  EXPORT_SYMBOL_GPL(add_bootloader_randomness);

This is more or less what I have done. credit_entropy() calls
crng_reseed() which crash badly.

Will check again, but I am sure it will give me same result.

Regards,
Ivan
