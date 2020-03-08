Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990AE17D2C4
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCHJAu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 05:00:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54565 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgCHJAu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 8 Mar 2020 05:00:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so2780541wmc.4;
        Sun, 08 Mar 2020 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbPsq1rZ+x/H5maMlysEeMg2kNODV83Sx1BWK6bggxY=;
        b=i0X7UqA9rF0hRyuyjOE+QnDFd+vWZTWCc0hfa4PhOYElxE3tSx8L/kKTtuI6wgQwIg
         R7p/BwH3P1lR6EMDFCy2DGRRJJGBqtlq8XpHcA3D9OVf0ExvmRMogTiM0yTR8V0O0d4I
         Cdl1j7J1ynlGm/T2c7cQY7SvRc5af0BHUy+VCpwJQa/2z2qMvyoQ38TiM9DaHvI2X/OI
         Hvh/X6jqadxAIVLMxc0aVwqaYykotgIzW0amm84+eljwjACC/gZ7jFb6b14zuxt9WoSc
         GlAMtTbRl4cskUDoo7oZttZNnBdGd0mR4XJHLNFehQOe1BRVQwHSZUdUeNuJJeN9Tno2
         n56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbPsq1rZ+x/H5maMlysEeMg2kNODV83Sx1BWK6bggxY=;
        b=X4SmTVoxLv8N68wh8Wi8RoidJdGmS0kMzfZyKYWyc7+YJgEx8Q9w0zH7qhhLJ0q4Hd
         gFJFw/z1jOFX0C+pMQAPLKjPC4iIJjUgwL8Nql/Cg+WQwQ+XUZhjqLJk2z+rn1Z8Dkir
         YP0ccwJG3n48hrUDfwpuMeE6UkL6de1CS/p0Q7YWyIo6vB+ajCGhwCNq6RY8dcbioijS
         RVy6x8V1rkcUwEGeWmjmDkX1ucyy23KSk/mmQVLOx+p/U9azcIhklLYRVrbWsR7ZkqqO
         jbYjE6Ixprl7BsWBnZ1hNOJB+6O7wGpy7bXmbiBNHh7Md53GQnBd75ddvC0LDAt47viw
         6Sag==
X-Gm-Message-State: ANhLgQ2jVOddA2P/ZAl3shjvLLVr5VjYoImolOw/nx91cwFTImNFHH24
        sP1vko55ifOxKQ93aholPRM=
X-Google-Smtp-Source: ADFU+vvbnTnfLH/nBqVRzrfodbRG0G1WHC8PrDA/ZE2QJk4lCIVG0YbZst1d5XrdR0jnTzW5HYKrZg==
X-Received: by 2002:a7b:cc8a:: with SMTP id p10mr3646380wma.10.1583658048246;
        Sun, 08 Mar 2020 01:00:48 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a7sm943674wrn.25.2020.03.08.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 01:00:47 -0800 (PST)
Date:   Sun, 8 Mar 2020 10:00:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: Re: [GIT PULL 00/28] More EFI fixes for v5.7
Message-ID: <20200308090045.GH32920@gmail.com>
References: <20200308080859.21568-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit b9d8b63e340392d7f3ad79881f36a550566cbbbe:
> 
>   Merge tag 'stable-shared-branch-for-driver-tree' into HEAD (2020-03-05 09:58:20 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to dfb2a1c61fcdc8be5dd74608c411c78008a0f078:
> 
>   partitions/efi: Fix partition name parsing in GUID partition entry (2020-03-06 11:17:42 +0100)
> 
> ----------------------------------------------------------------
> More EFI updates for v5.7
> 
> - a fix for a boot regression in the IMA code on x86 booting without UEFI
> - memory encryption fixes for x86, so that the TPM tables and the RNG
>   config table created by the stub are correctly identified as living in
>   unencrypted memory
> - style tweak and doc update from Heinrich
> - followup to the ARM EFI entry code simplifications to ensure that we
>   don't rely on EFI_LOADER_DATA memory being RWX
> - fixes from Arvind to ensure that the new mixed mode approach works as
>   expected regardless of where the image is loaded in memory by the UEFI
>   PE/COFF loader
> - more fixes from Arvind to make it more likely that the image can be
>   decompressed in place, regardless of where it was loaded in memory
> - efivars bugfix and some cleanup from Vladis
> - incorporate a stable branch with the EFI pieces of Hans's work on
>   loading device firmware from EFI boot service memory regions
> - some followup fixes for the EFI stub changes that are queued for
>   v5.7 already
> - an endianness fix for the EFI GPT partition table driver

>  22 files changed, 319 insertions(+), 141 deletions(-)

Applied, thanks Ard!

	Ingo
