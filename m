Return-Path: <linux-efi+bounces-4249-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A438AFEBC1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2C518812D7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB719F40B;
	Wed,  9 Jul 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzSYRn9E"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD32DE216
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070680; cv=none; b=SkUy1pxJ6DHxAtkedIICeaLSC9JnvXqbVBKIttqtoNaWc598/8JJkO6+aO17QX1g8UHb2zbrDklcPGYNM8NyalQqvyI//zzCZZJCTV4rkzCpH7aXr+d0t1YN/HWy9ZxJL/2BT2pYRoLzVC72O9kczPy4+LSKeO1PdCtFMH4YTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070680; c=relaxed/simple;
	bh=EHbBHE13kC79LDmdc23gmqBQNvLgY4u0iCZVgT2r5Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT7Cw4/UDQ0tI9sDF4zhQCfTvThGAabRP//VzdM9VAGtRtzGhZbJUOE7ALmTqjEORStSXV+/uGCqZVphDor9GdSKbUnXJlGxKd0gujzp+ZzmVHvkg3O6HrcXgrqEVZ9kMocJo8dSE1kmktAdb8FqyFHedVlBmDJbPdsqMpBCFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzSYRn9E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752070678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHO9YyMYmJWGNN4TK+hwZojviX0X+UcJREW3wMl0Z/I=;
	b=DzSYRn9EilWmZbuLQyVaIRh9t36uad0fJMoenY6KZ92/w4H3uE9MWSeeeLh7Jctg/PZQVQ
	bw2kp2DjCQRcHZsHfD4rm5UXLLD5f1oCxAUrv1CdMiYNnir/M1cO4tiZJR6eS6hpeBXO1Z
	P+9R1MIC8W/yvX+IfaOwIfV/fDwPNYY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-534JlDTEP6aNjVL1Sa69TQ-1; Wed,
 09 Jul 2025 10:17:54 -0400
X-MC-Unique: 534JlDTEP6aNjVL1Sa69TQ-1
X-Mimecast-MFC-AGG-ID: 534JlDTEP6aNjVL1Sa69TQ_1752070673
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6DF319560AD;
	Wed,  9 Jul 2025 14:17:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61C8930001B1;
	Wed,  9 Jul 2025 14:17:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id DDE6418000B2; Wed, 09 Jul 2025 16:17:50 +0200 (CEST)
Date: Wed, 9 Jul 2025 16:17:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi: add ovmf debug log driver
Message-ID: <2mn65slwkwmjpeilma2isw7zgabdmda4rhpqjiutwdwqno2wrh@zghymlce2fiy>
References: <20250708125624.734132-1-kraxel@redhat.com>
 <6edfa099-ab0c-41f6-89ea-0fd67666dd05@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6edfa099-ab0c-41f6-89ea-0fd67666dd05@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jul 09, 2025 at 03:58:58PM +0200, Krzysztof Kozlowski wrote:
> On 08/07/2025 14:56, Gerd Hoffmann wrote:
> > +MODULE_DESCRIPTION("OVMF debug log");
> > +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:ovmf_debug_log");
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index db8c5c03d3a2..ac0a03ec3452 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -263,6 +263,14 @@ config EFI_COCO_SECRET
> >  	  virt/coco/efi_secret module to access the secrets, which in turn
> >  	  allows userspace programs to access the injected secrets.
> >  
> > +config OVMF_DEBUG_LOG
> > +	tristate "Expose OVMF firmware debug log via sysfs"
> > +	depends on EFI
> > +	help
> > +	  Recent OVMF versions (edk2-stable202508 + newer) can write
> > +	  their debug log to a memory buffer.  This driver exposes the
> > +	  log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
> 
> Where did you document new ABI?

The log buffer header struct is documented in the header file for the
edk2 code:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Library/MemDebugLogLib.h

take care,
  Gerd


