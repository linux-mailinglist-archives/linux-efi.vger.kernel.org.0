Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324171DE832
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgEVNkL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 09:40:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53156 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgEVNkL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 09:40:11 -0400
Received: from zn.tnic (p200300ec2f0d4900a503efeda57d2ecc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4900:a503:efed:a57d:2ecc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07B341EC02DD;
        Fri, 22 May 2020 15:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590154810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Pw4qZddkN9GARxEt8dEIB/8bXHBWj3ikGLqk4GalsDI=;
        b=OMXeKQ+lA5i44nvFQReQLVYF4u5t5YzXL+c9LW740nPyR9rd7bNT752oRFxrmq05fHnm2y
        A9KklmoK6nbusEHZtzVRcWBa0d3ekTrHXUuDyYWz2tdqkDbspvDnn6VIGQfWFDiyKWoZML
        Y1XxO57yR1hRM37VQwpeYIjqI92mO5c=
Date:   Fri, 22 May 2020 15:40:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
Message-ID: <20200522134004.GF28750@zn.tnic>
References: <20200517125754.8934-1-ardb@kernel.org>
 <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 22, 2020 at 03:06:20PM +0200, Ard Biesheuvel wrote:
> Ping?

Did you want to make your tags unique from the next pull request onwards
and I were supposed to pull this one as is?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
