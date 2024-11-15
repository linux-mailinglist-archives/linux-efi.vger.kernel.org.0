Return-Path: <linux-efi+bounces-2159-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373669CDDAE
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 12:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D0B280CD7
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A06618871E;
	Fri, 15 Nov 2024 11:46:31 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FE149C53
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671191; cv=none; b=jV0T050F3nkImAvEI9cILL/NsMJzfUm9iDVA8awSOxdj0L0V8mogXjmPfWETlWEsf/d7gUZpKAEq5uMVZXDAfoEFKYRBh4ZS7H8fosaRoRDs8L/AqLVUiatm2eoKvUoD5T/sY3L3GiEcleSIm2lkiURZx7/QdYGbUGd9bJQnpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671191; c=relaxed/simple;
	bh=XM3sbw7bYS82ohooYZ8bsJRbkqatLsMmYTxrgZIfhUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b82Egqx23XY/kUl68beP74DSyEIjR9MgOJ/GQ/e6hZR7IUtqtif5Qooaqg3euF1sQEnSsUk7XjeJWx6lxR2gPjvTzF/1AnzvHus8aU/JOEatu84ChVE7O5Ra6WDkibjb7wvgRpk8knmS/RicSy1DjJhhj1RDXVivqui9aabfF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so286375666b.0
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 03:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671188; x=1732275988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h0Afa75gJUW3TESRrzo4QbypGloUagaIUM1oR3UelA=;
        b=QZhM4QfytCzVsZiswCXd0Gg+dw4PTyd7wlID/fGJhh9p1nfl8xJzSDfCmKtXl1XswD
         CrMj31dm7r81D3CsRDhHJZDO8pUh4fXM8shgjMSQdLyzJW98TyJazBtQXFxuK72Kp2VW
         Dk6A0LejQdtofVkbGOR/3LZ0pJGS+umOtJ1KrIXlEOrA5Ndp6ovndxYc+bvgPtV+Yx/O
         8CZ+N7AVoI5fPb8SZMnobzvA304fGYFRNkRRrJ1lTODxMNpico5bhN8vYhqnhsSiSRT5
         cdh5bqTpEtxfklX8iMAA9c0hZiumW6wyUys0WvWtLnvDg6FNfyp8iLGfxVIRjl+7mRNq
         IaDg==
X-Gm-Message-State: AOJu0YypYgKBDKS3lTy57L+EI5sWX3bDP4QIWLenQo28EiRlEFkKDTIg
	RB5kgIv1gqr2hNcmlqrpXJfhYpdxyH3cZGsPvS2w9W1idbsy+CPc
X-Google-Smtp-Source: AGHT+IEz2A6yzQwuizCs9RcFC3TN5Ky8T7LIuyVXk5nzf3BejcyFkTSFfWIGFkl0gxrRHueIgel/wA==
X-Received: by 2002:a17:907:9288:b0:a8d:4631:83b0 with SMTP id a640c23a62f3a-aa4833f6cabmr192845466b.5.1731671187662;
        Fri, 15 Nov 2024 03:46:27 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcadsm171214966b.112.2024.11.15.03.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:46:27 -0800 (PST)
Date: Fri, 15 Nov 2024 03:46:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Usama Arif <usamaarif642@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
Message-ID: <20241115-singing-crazy-chipmunk-db06ef@leitao>
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
> 
> [0] https://bugzilla.suse.com/show_bug.cgi?id=1231465
> 
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Link: https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Breno Leitao <leitao@debian.org>

