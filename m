Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356BA42B922
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhJMHdD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 03:33:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhJMHdA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Oct 2021 03:33:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD3641FF94;
        Wed, 13 Oct 2021 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634110256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhfXZJsynHXeyAbLDW+uMMRCkXibzgFnenZPaIVd2Uk=;
        b=lhcCX5wDaiF2DjEztmza0H2Kx+jMDkyz7cWvYQWBlPULjcOShsfBXNPSxBaGvaAClO7Cls
        A0evEwt9t7XtAHuOoCowKLa6+gyBp6H3jJyyttRQm74TdzEunQ3Yc7uIPqd1u4tG/viK0A
        SM3FMVPXwOVfUTBwK+LxQ9qAttrYpoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634110256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhfXZJsynHXeyAbLDW+uMMRCkXibzgFnenZPaIVd2Uk=;
        b=ESFTWWjSP6XBpi1GMKdZTL2zV5io+RuihJKG/DOwx20L9Tuh7cqTDBPoriPwWqo7ocm8Hb
        cAkEji7Yj1JFA1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9251A13CBE;
        Wed, 13 Oct 2021 07:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 62NZIzCLZmGMdQAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 13 Oct 2021 07:30:56 +0000
MIME-Version: 1.0
Date:   Wed, 13 Oct 2021 10:30:56 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND] Re: [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL
 output as bootloader randomness"
In-Reply-To: <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
User-Agent: Roundcube Webmail
Message-ID: <4eccf707f2553f0f66ae3789b5689231@suse.de>
X-Sender: iivanov@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

Quoting Dominik Brodowski (2021-10-12 11:40:34)
> Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
> > This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
> >
> > When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled add_bootloader_randomness()
> > calls add_hwgenerator_randomness() which might sleep,
> 
> Wouldn't it be better to fix add_bootloader_randomness(), considering 
> that
> calls to that function are likely to happen quite early during kernel
> initialization? Especially as it seems to have worked beforehand?

I have tried. I made wait_event_interruptible() optional, but then
crng_reseed() segfault badly. And I don't think crng_reseed() is
something that I could fix easily. Suggestions are welcomed ;-)

Regards,
Ivan
