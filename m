Return-Path: <linux-efi+bounces-1723-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D192977CC0
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABAB1F280B1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677F175D45;
	Fri, 13 Sep 2024 10:00:58 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEC42AB0;
	Fri, 13 Sep 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221658; cv=none; b=uoZWyemTyE6C3usg4mIuCNHaQ/Sltea3E2NVeyxRk8ntIYD+VrLoJJy8Cxy3rrIhqhxG6PD1h2hcz1fdu9WB4QBTudJ33ZZQqMF3iHnVM0NiZAr1XXnoEh86YNCuyihLzTYYwwnmG/lsfy+GDHyqaSl7X5lWE+LP29vAS+JhOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221658; c=relaxed/simple;
	bh=QSF8YJfwVwXkhZ1zLXCWLTzriYuwxHs8CKebbxqwYIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dud1HLpDAziA/+sUTZ5gZVCZpwSwH6RA3Rk3b16nLKnnPwzw7jHVgWBf0zXioUBGB/BtScohXPWwBILs/wFtvt3/oG0iIpoR7zjXWVmi+N6bkGFXJk6pHyMw+nQNP5dd6dmOLwsADignf1/NXUrMsSfjFtQwhjGUh1VpvbTgHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so81590966b.2;
        Fri, 13 Sep 2024 03:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221655; x=1726826455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09pv4sj5GSUTJwvH3UZSqU8pyb7qiHJg5RnUYc2hPL4=;
        b=o1yvkyq7XiTRt5RYnzfRzGtskc8bbZ9a4sIdbfK/IXYM8sUXJAMNKUPxq+gi+PMo3B
         nGWRCY/c/cVJiiD2bApGStR2g002+8RED+gEgYRIa5UXDileHR/MtUpK+t5BnoCC1Af2
         RcjBWuzWqBABKwPQriDQld37arKfe0WHBIBGD19VhOHwbGlWetabPs6ihT7pONoBOyYn
         f3r1d7HCBZqcQCIFyHKinv7oyJzgyFPy8ulH5nSFrPh75EDtm4lp0SL0F2IZgr4iUZNA
         S55cVtaNzHmQaVSVRBoriKDvq7fj77ovTUxONVO/zi+8XanUznk8VcxF3aicnY86Fang
         Fduw==
X-Forwarded-Encrypted: i=1; AJvYcCUCWIFER/fou3493pLosM0sBHxORhEebej6NRf/L367UCsQ8Tad91CrQXIGqxS8T+JBj5rn1Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuXlJedqbDhMnHWIdV+WONGwcswF4rJqu+CTl6U7wg0UU0pY4D
	DuVVet+JmahPLTRjNQgLQ3IRJvHMzn7OfAp4bPNA278aq2suVrRdeFHI8g==
X-Google-Smtp-Source: AGHT+IELxvDdM9koekEJ+3Nkq4IiUI2WQW8uYAygUPWJ54+XRA4IAPrJUmr9C2ubj6Llp/JEdD0uPA==
X-Received: by 2002:a17:906:4fce:b0:a8a:7c4a:d1d4 with SMTP id a640c23a62f3a-a9048192f49mr133511966b.65.1726221653908;
        Fri, 13 Sep 2024 03:00:53 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c624efsm851786966b.114.2024.09.13.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:00:53 -0700 (PDT)
Date: Fri, 13 Sep 2024 03:00:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
Message-ID: <20240913-jolly-unique-lion-2e2bd8@leitao>
References: <20240912155159.1951792-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912155159.1951792-2-ardb+git@google.com>

Hello Ard,

Thanks for the fix!

On Thu, Sep 12, 2024 at 05:52:00PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The TPM event log table is a Linux specific construct, where the data
> produced by the GetEventLog() boot service is cached in memory, and
> passed on to the OS using a EFI configuration table.
> 
> The use of EFI_LOADER_DATA here results in the region being left
> unreserved in the E820 memory map constructed by the EFI stub, and this
> is the memory description that is passed on to the incoming kernel by
> kexec, which is therefore unaware that the region should be reserved.
> 
> Even though the utility of the TPM2 event log after a kexec is
> questionable, any corruption might send the parsing code off into the
> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
> instead, which is always treated as reserved by the E820 conversion
> logic.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Breno Leitao <leitao@debian.org>
> Tested-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Tested-by: Breno Leitao <leitao@debian.org>

For stable, having the fixes will help stable folks to decide where to
pick. Based on investigation, this was introduced by 33b6d03469b22, so,
we might want to have the following line:

Fixes: 33b6d03469b22 ("efi: call get_event_log before ExitBootServices")

Thanks again!
--breno

