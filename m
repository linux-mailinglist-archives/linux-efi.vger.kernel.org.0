Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152B5469149
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 09:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhLFISC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 03:18:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42442 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbhLFISB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 03:18:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44FCA2191E;
        Mon,  6 Dec 2021 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638778472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lASzPZyf0vP581LqVx8OHHRYH2fisiSUp6Nw5EbwMyY=;
        b=IYHmx3JfONk4ERn6UKXOpEdX7Kqx72BZN90v1LdRWDas1WVzXyKNwoaQlFKE0YDLR5YUEM
        QkAjrmS16afTJp2Lvg1/H1b53zJxKevq6+ief+IGg4K/JTQeABAYxJrk+3mG93zHiGaHrD
        20r0KmCnYxHMMrFsdYwO+02hZRygJzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638778472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lASzPZyf0vP581LqVx8OHHRYH2fisiSUp6Nw5EbwMyY=;
        b=GJSMYMwfOO5/9Arp3tcqmqEZfTRZKINDOzDJM+wCrJL2bdQdFL2cswO4exR4tZgu6DVHDN
        fdC9GwzMkqsAW4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28C8513AC7;
        Mon,  6 Dec 2021 08:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4OuKCWjGrWFXCAAAMHmgww
        (envelope-from <iivanov@suse.de>); Mon, 06 Dec 2021 08:14:32 +0000
Date:   Mon, 6 Dec 2021 10:14:31 +0200
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, hsinyi@chromium.org
Subject: Re: [PATCH v4] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <20211206081431.e3cl2rbvgpvbouff@suse>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
 <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
 <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12-03 16:39, Jason A. Donenfeld wrote:
> Date: Fri, 3 Dec 2021 16:39:55 +0100
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>, "Ivan T. Ivanov" <iivanov@suse.de>, Ard
>  Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, LKML
>  <linux-kernel@vger.kernel.org>, hsinyi@chromium.org
> Subject: Re: [PATCH v4] random: fix crash on multiple early calls to
>  add_bootloader_randomness()
> Message-ID: <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
Tags: all linux me ring watch

Hi,

> 
> Hi Dominik,
> 
> Thanks for your analysis. Some more questions:
> 

<snip>

> Also, if you have a nice way of reproducing this, please do tell - I'd
> like to give it a spin if possible.
>

Initial bug report could be found here [1]. Comments 14 and onward are
probably helpful. To reproduce the issue I have downloaded "assets"
from [2] and recreated test environment as found in autoinst-log.txt [3].
Search for qemu-img and qemu-system-aarch64 in the log above. Login
credentials for the images could be found by searching for "password"
in the same file.

Regards,
Ivan


[1] https://bugzilla.suse.com/show_bug.cgi?id=1184924
[2] https://openqa.opensuse.org/tests/latest?arch=aarch64&distri=opensuse&flavor=DVD&machine=aarch64&test=extra_tests_in_textmode&version=15.3
[3] https://openqa.opensuse.org/tests/2052459/logfile?filename=autoinst-log.txt

