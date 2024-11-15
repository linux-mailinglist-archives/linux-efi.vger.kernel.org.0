Return-Path: <linux-efi+bounces-2155-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471029CDC2E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19D0B21F3A
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F5192B9D;
	Fri, 15 Nov 2024 10:10:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9D18FC91
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665408; cv=none; b=QoUEBi31e/bii1uVsdmy0MczK8YSi/bbFJyHBNFBsZq9iT4cVHRQZ0ftmroXOJcs1cc0O8JpYp9qZBA2vaGl6fTND6sCvif+EuKhVmpOIO7QQyeBCyuxtW+NbeWH6QJKLckPdo/E6uw+8hpG2eL2CvQSca3vOrlYc4KLKpc9n28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665408; c=relaxed/simple;
	bh=UgnuYNW02zUCBhXOUdb6vAEEFpXNxuMjIkqVqUqPgH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYqDfEwXe5bMYaBs3rJXD37YrfDWm0Pq27Vq9ebEhSPunRhXMAQvA4Go+3TCCpRblpRgr3Mdb5YNnT3VJNnJf/r+IdAacN7JuSlg9J9o/CwS5Yd+lkaZ65T7mj7VsaNZIT/yIsnnCmrK+z68E+oqpEOTTmEzfA/Z5QEzK4KN+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so270172666b.0
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 02:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665406; x=1732270206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux7Wg0cpA6sgHR7iVbSVOd3P3/4F/cesVpf2dl76X+o=;
        b=l1ow16xhKaTatcjwm2IC1N7zf2Bct4Uw+li1rAtgO86wuQ3Bs14BnAmKloK7tLdse1
         DoxkTDoYg5z6GJtblZN9pQS3k2Emu6ewerMAU2hUA3pgPI7QaHV9JafGP+imQtqxVZaL
         6JaYVkMsQf127ut848+gYb0YY0GVHHNrvO1aR9IonMauvUKLqrZd8bIqIAJ11EKoF+vd
         023MzNbE4AerzL5HMFocnXmCbHivxYjLH5uzOfCBscMxE8ZZcdoYI8R/jCAX0jicEnhd
         utR6odfqKLeTYr2DVSKnmu8c+aoHhMdWVdulOvgfcKVO1uFrofOn/ria3lXCw/O0ODOc
         EwYw==
X-Gm-Message-State: AOJu0Yzm3jU8xb0n0ecs4jWmErIgQwyt04k3E+rzSlPrEv2zoSg5c1GN
	1s5+UozEcn0flnP3KjQ3IInN0YfRww7C4rJagsiSF/jgZ1nqPxqH
X-Google-Smtp-Source: AGHT+IEBkAJUevvh9cwFoUetYRuuSG6HcINGHTAdEMNZfpq+IQkWNHxov6Ty5oHQ4CWNBvlr/0vfHA==
X-Received: by 2002:a17:907:3f86:b0:a9a:a3a:6c58 with SMTP id a640c23a62f3a-aa4834261f2mr190528866b.22.1731665404905;
        Fri, 15 Nov 2024 02:10:04 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0452a0sm162526566b.148.2024.11.15.02.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:10:04 -0800 (PST)
Date: Fri, 15 Nov 2024 02:10:02 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Usama Arif <usamaarif642@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
Message-ID: <20241115-honored-macho-deer-dc6def@leitao>
References: <20241031175822.2952471-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031175822.2952471-2-ardb+git@google.com>

Hello Ard,

On Thu, Oct 31, 2024 at 06:58:23PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> There are reports [0] of cases where a corrupt EFI Memory Attributes
> Table leads to out of memory issues at boot because the descriptor size
> and entry count in the table header are still used to reserve the entire
> table in memory, even though the resulting region is gigabytes in size.
> 
> Given that the EFI Memory Attributes Table is supposed to carry up to 3
> entries for each EfiRuntimeServicesCode region in the EFI memory map,
> and given that there is no reason for the descriptor size used in the
> table to exceed the one used in the EFI memory map, 3x the size of the
> entire EFI memory map is a reasonable upper bound for the size of this
> table. This means that sizes exceeding that are highly likely to be
> based on corrupted data, and the table should just be ignored instead.

I haven't seen this patch landing in net-next tree yet.
Do you have plan to have this merged into 6.13?

Thanks
--breno

