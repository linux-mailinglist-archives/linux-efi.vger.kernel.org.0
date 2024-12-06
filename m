Return-Path: <linux-efi+bounces-2310-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5F9E74DB
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 16:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CE2165882
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2413AA5F;
	Fri,  6 Dec 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf9wDp1k"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596362171
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500174; cv=none; b=gc76HfJvMS0OysnO7IXg5HEpS/xrKc+gBS9vkxLTLQscdXXja3szKDn4cqX/27M5XA7M3AlNPsx7oN8kLfIeT8+N+eSmLR8YSZ3fv+lWg+uOFNoZ0RsPmHBrbBzGSW6Dzs8njzodJTDe/4fTExnevZ2hKCp586/IPNOmbF9G2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500174; c=relaxed/simple;
	bh=JKu8D9zjWrW4AzzMiX2tOHfoTgc0vn6z7z/ltcMteOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUA1jC7u5lzBv5Bt/khjtD/Qc6JUPUO5wU1DzjmEFMAHKgPUqWhq1amlC37rOx260Xe1HZrY4B7YnfsP1x0Tx+JpsF0dEJGUr4+BqLQG5lqC7M5oakCdqZE5SvAnLSfjSl+0Of5atM3QPWKAn/JnOOxywZ5qTNZmf8RgzKzfrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cf9wDp1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733500171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eN5PYZB01adqE9Usv47QTRr0aGDQJjRFeo3VSWxRbA=;
	b=Cf9wDp1kSNg9WWos83g4to/1JsfgWMkYhbkX2AQeb7csYv10ynO1+nmjhWJ4L4VFR8WwxZ
	+iwbobRM+Tl8AblfwgioGzULUKR14paVgGLgycaDXOuBs9tztpT5jbHHhZGp8qCna5aTLg
	jrLHj3dsnzwrJa3PN2sYLQ5K+YNhQMg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-lFnJcB1sP_Ox3Too1L7X2A-1; Fri,
 06 Dec 2024 10:49:30 -0500
X-MC-Unique: lFnJcB1sP_Ox3Too1L7X2A-1
X-Mimecast-MFC-AGG-ID: lFnJcB1sP_Ox3Too1L7X2A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 512911956057;
	Fri,  6 Dec 2024 15:49:29 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB70D300019E;
	Fri,  6 Dec 2024 15:49:28 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
	id E07FA254644; Fri,  6 Dec 2024 16:49:25 +0100 (CET)
Date: Fri, 6 Dec 2024 16:49:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Peter Jones <pjones@redhat.com>, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH] efi/zboot: Limit compression options to GZIP and ZSTD
Message-ID: <ojt3y2r3svozxh2pebbj77kntqpuxg5uqnvkuemk2rb4yzngpd@etbgdr66dd3t>
References: <20241206142459.3974886-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206142459.3974886-2-ardb+git@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Dec 06, 2024 at 03:25:00PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> For historical reasons, the legacy decompressor code on various
> architectures supports 7 different compression types for the compressed
> kernel image.
> 
> EFI zboot is not a compression library museum, and so the options can be
> limited to what is likely to be useful in practice:
> 
> - GZIP is tried and tested, and is still one of the fastest at
>   decompression time, although the compression ratio is not very high;
>   moreover, Fedora is already shipping EFI zboot kernels for arm64 that
>   use GZIP, and QEMU implements direct support for it when booting a
>   kernel without firmware loaded;
> 
> - ZSTD has a very high compression ratio (although not the highest), and
>   is almost as fast as GZIP at decompression time.
> 
> Reducing the number of options makes it less of a hassle for other
> consumers of the EFI zboot format (such as QEMU today, and kexec in the
> future) to support it transparently without having to carry 7 different
> decompression libraries.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


