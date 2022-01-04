Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A85484433
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiADPGQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 10:06:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiADPGQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 10:06:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3B51F37F;
        Tue,  4 Jan 2022 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641308775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vgKwtNFKn3CVgM8+iA7ADHFikx+F6a6TIhwVWbpnE88=;
        b=GaY+pgmW5XLRGc/YqRFE7SDd7dZAeiC/k06RZEvF45eGzAqrvAVDbqCd4Qf8m0YANu3X7a
        rKZ2ODTE8gj5oABISTwpq8BC2IYBbwpCRKiymVqtJHoi6Cv2BXBCPruXFpOgS84Eb9C0VU
        3+1bgVVZYS0Z9Yth+t2eYgIA+CvCxME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641308775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vgKwtNFKn3CVgM8+iA7ADHFikx+F6a6TIhwVWbpnE88=;
        b=XWXQqqGOCUTC66MDW7DEeFAceOEmduAoft/bYRWg8ivvMcfnFeLK6DvV5PZZ/q/WDXoyML
        IQL73Ofj85x4oqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 238D713B16;
        Tue,  4 Jan 2022 15:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5dblBmdi1GE9IgAAMHmgww
        (envelope-from <iivanov@suse.de>); Tue, 04 Jan 2022 15:06:15 +0000
Date:   Tue, 4 Jan 2022 17:06:14 +0200
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v4] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <20220104150614.txvf7sbabhsbuxcs@suse>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
 <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
 <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
 <20211206081431.e3cl2rbvgpvbouff@suse>
 <CAHmME9q6DnMk=p5kL0c1e4TxJOLpdxJpm3RbbgsNE8x1PWwi9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9q6DnMk=p5kL0c1e4TxJOLpdxJpm3RbbgsNE8x1PWwi9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12-30 19:05, Jason A. Donenfeld wrote:
> Date: Thu, 30 Dec 2021 19:05:23 +0100
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: "Ivan T. Ivanov" <iivanov@suse.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Theodore Ts'o
>  <tytso@mit.edu>, Ard Biesheuvel <ardb@kernel.org>,
>  linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Hsin-Yi
>  Wang <hsinyi@chromium.org>
> Subject: Re: [PATCH v4] random: fix crash on multiple early calls to
>  add_bootloader_randomness()
> Message-ID: <CAHmME9q6DnMk=p5kL0c1e4TxJOLpdxJpm3RbbgsNE8x1PWwi9g@mail.gmail.com>
> 

Hi,

> Hey Ivan,
> 
> On Mon, Dec 6, 2021 at 9:14 AM Ivan T. Ivanov <iivanov@suse.de> wrote:
> > Initial bug report could be found here [1]. Comments 14 and onward are
> > probably helpful. To reproduce the issue I have downloaded "assets"
> > from [2] and recreated test environment as found in autoinst-log.txt [3].
> > Search for qemu-img and qemu-system-aarch64 in the log above. Login
> > credentials for the images could be found by searching for "password"
> > in the same file.
> >
> > Regards,
> > Ivan
> >
> >
> > [1] https://bugzilla.suse.com/show_bug.cgi?id=1184924
> > [2] https://openqa.opensuse.org/tests/latest?arch=aarch64&distri=opensuse&flavor=DVD&machine=aarch64&test=extra_tests_in_textmode&version=15.3
> > [3] https://openqa.opensuse.org/tests/2052459/logfile?filename=autoinst-log.txt
> 
> After a few rounds, Dominik and I converged on a set of patches that
> are now in the crng/random.git tree. Do you think you could try this
> tree out against your various test environments to confirm it fixes
> the issue SUSE was seeing?
> 
> Tree is here: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
> 

Sure, once I have result will post back.

Thanks!
Ivan

