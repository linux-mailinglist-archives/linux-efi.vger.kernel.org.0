Return-Path: <linux-efi+bounces-1699-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49C974CF5
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B182821BF
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3634545;
	Wed, 11 Sep 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkxcEUMs"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153E2C859
	for <linux-efi@vger.kernel.org>; Wed, 11 Sep 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044285; cv=none; b=rXVCdBlY326EvPWlbxxdpdrK9Zds2ctwmKJRbZ6GKJaFwst/KZEPaitEpQF9E1X2dtgF1cTUSPR7Ru/zGxEDytJHgkH2NUaPsQWGwIpBOwFyKxqiRR1vLpK6kw04tIZQoAckREhnNIvgYbwlzq0cXhDO9iyiC/qoa4UMDaCwHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044285; c=relaxed/simple;
	bh=ADrLbX0M+AHUl1ITZISYEYBLmy4DT4vMBSeErWdQwIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2X1ZHaB6VOMP4aVL7TjdwklHTGTGk6uWCDLo1TM0LWwKjFOp44EYlQOqz9wK4Poq29yUi23tph05gdh/qMCW0KG5hgNaUGOcq73cZesWT11H7dr4YxRWm7E1V9oqrJEZgMFxm6FXo50QTTulGKpqI+1rtZ1ekGH+ppc0wsNU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkxcEUMs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726044282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq8JaCWyziRBjtKqtbfl0xssh8Fkw9br1JpvTEvClbc=;
	b=UkxcEUMsWJfx0t2TOpXj9LzsQr1U3F+YEusWLt8gPOPemAttcH2O+yCqi/z+YEHIf5OTjd
	lLPGzov4Jh5ZTuxbdrdNyOzjUgf2/hSJOD7eqJ/rpnz0aRU+umt0StXSbGZQccQ1vzhlU2
	7GYxz34uAvoFHW+fxjIh3WeG/57dFXM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-ohkZIDUfPKurTa_aKaUB3w-1; Wed,
 11 Sep 2024 04:44:39 -0400
X-MC-Unique: ohkZIDUfPKurTa_aKaUB3w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94331956077;
	Wed, 11 Sep 2024 08:44:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 292773000235;
	Wed, 11 Sep 2024 08:44:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 02D531800635; Wed, 11 Sep 2024 10:44:34 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:44:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: devel@edk2.groups.io, afish@apple.com
Cc: leitao@debian.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com, 
	rppt@kernel.org, usamaarif642@gmail.com, gourry@gourry.net, rmikey@meta.com
Subject: Re: [edk2-devel] EFI table being corrupted during Kexec
Message-ID: <5ey4rmwtcnoukoh57o7ysgolyyzjcwnc3x6ao2zzu3l32xee43@o62hzctqe36q>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <BABE4F07-DF49-48C5-BAB7-B5986C035C8E@apple.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BABE4F07-DF49-48C5-BAB7-B5986C035C8E@apple.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 10, 2024 at 08:44:40AM GMT, Andrew Fish via groups.io wrote:
> 
> 
> > On Sep 10, 2024, at 6:58 AM, Breno Leitao <leitao@debian.org> wrote:
> > 
> > 
> > We've seen a problem in upstream kernel kexec, where a EFI TPM log event table
> > is being overwritten.  This problem happen on real machine, as well as in a
> > recent EDK2 qemu VM.
> > 
> > Digging deep, the table is being overwritten during kexec, more precisely when
> > relocating kernel (relocate_kernel() function).
> > 
> > I've also found that the table is being properly reserved using
> > memblock_reserve() early in the boot, and that range gets overwritten later in
> > by relocate_kernel(). In other words, kexec is overwriting a memory that was
> > previously reserved (as memblock_reserve()).
> > 
> > Usama found that kexec only honours memory reservations from /sys/firmware/memmap
> > which comes from e820_table_firmware table.
> 
> The E820 table is not part of the UEFI standard and it is produced by
> a library in the OvmfPkg for “special cases” so I guess that lib could
> have a bug?

This "special case" is direct kernel boot ('qemu -kernel vmlinux') and
loading the linux kernel as EFI binary failed.  That should only happen
with linux kernels so old that they do not have the efi stub.

Also note "problem happen on real machine" above, so it clearly is not
something OVMF-specific.

take care,
  Gerd


