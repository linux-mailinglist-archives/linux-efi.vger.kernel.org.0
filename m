Return-Path: <linux-efi+bounces-2854-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1BA48652
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510BD3B0C24
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F81DDC16;
	Thu, 27 Feb 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3BhlWR+"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19661D4335
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676406; cv=none; b=VwdWiAELjNyky4aAUUsdoS9vs2cuV2Lqosw7eiM7BwIizjmICT1/Obf7dQp+P1ynTihYhoaS4nzGswJfIFG4amIrXN5mBpO01xdqjUHhmBvLWVNJ6K+duzSvJn890VtSKiY5+LOtuwAmFsb7GPSvzXsCqGOnX0Fq+ZD4NooowEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676406; c=relaxed/simple;
	bh=TC6frsDM+/9tSsHy7M6daCpw9KqvuE9mdRA1+bIEnyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhjs+bd15Tj4DiNO0jdvsqYp9dkdCCtL2FBk3vaQGPG/D4T2zajSv+xAp5zsGLd3vV/uTHn1YCY8G3OheJE86INH1vCLFE927suBUMsOxLaB1cWJ8gaEaNIidp4bbQAayiAn9I6FMj82VIotoSA6YC8/TGnGFmFnomJ4q9X6RI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3BhlWR+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740676403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzXmsE9Expxm+FyvE3ioQhLue1pjlpaem6Ooi+vTdPI=;
	b=A3BhlWR+E9gAuGCCzUhmcGIp7GSVAhwJS862XAtU3vR5WVekxiotIGw+CGjvFutx/q2Q4g
	FkZGoAT5Y8L+73bVNeULid5gbq4wU4rKwk7Oqu0atHTQKCspQxX3HEekTsqtnUUeFf/EiO
	2z0fbSHCATRa72IDhmPSU3pW99aEPCM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-IzkHkFm3OxyVBCFJX_QD8g-1; Thu,
 27 Feb 2025 12:13:20 -0500
X-MC-Unique: IzkHkFm3OxyVBCFJX_QD8g-1
X-Mimecast-MFC-AGG-ID: IzkHkFm3OxyVBCFJX_QD8g_1740676398
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D231801A18;
	Thu, 27 Feb 2025 17:13:18 +0000 (UTC)
Received: from redhat.com (unknown [10.22.82.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29ABE180035E;
	Thu, 27 Feb 2025 17:13:17 +0000 (UTC)
Date: Thu, 27 Feb 2025 12:13:14 -0500
From: Peter Jones <pjones@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Lenny Szubowicz <lszubowi@redhat.com>
Subject: Re: [PATCH] efi: don't map the entire mokvar table to determine its
 size
Message-ID: <8f085931-3e9d-4386-9209-1d6c95616327@uncooperative.org>
References: <20250226201839.2374631-1-pjones@redhat.com>
 <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 27, 2025 at 08:50:08AM +0100, Ard Biesheuvel wrote:
> 
> Should we add something like the below to avoid mapping the same page
> over and over again? Or is this premature optimization?
> 

I can't honestly say I'm sure either way, but I'm leaning towards
thinking it's probably worthwhile.  On my development tree the number of
these we wind up doing in the maximal case is 31, and but in a typical
case it's more like 20, with a series that looks something like the
below list of sizes and relative addresses from the first entry.  (I
generated this with ls and awk, so it's not quite exact but it's
fairly representative.)  I've marked which ones could be eliminated.

map 264 at 0x0
unmap 264 at 0x0    <-- gone
map 264 at 0x146    <-- gone
unmap 264 at 0x146  <-- gone
map 264 at 0x2a2    <-- gone
unmap 264 at 0x2a2  <-- gone
map 264 at 0x43e    <-- gone
unmap 264 at 0x43e  <-- gone
map 264 at 0x548    <-- gone
unmap 264 at 0x548  <-- gone
map 264 at 0x660    <-- gone
unmap 264 at 0x660  <-- gone
map 264 at 0x84d    <-- gone
unmap 264 at 0x84d
map 264 at 0x191f
unmap 264 at 0x191f <-- gone
map 264 at 0x1a73   <-- gone
unmap 264 at 0x1a73 <-- gone
map 264 at 0x1b7c   <-- gone
unmap 264 at 0x1b7c <-- gone
map 264 at 0x1cd0   <-- gone
unmap 264 at 0x1cd0
map 264 at 0x21a8
unmap 264 at 0x21a8 <-- gone
map 264 at 0x22c2   <-- gone
unmap 264 at 0x22c2 <-- gone
map 264 at 0x23cb   <-- gone
unmap 264 at 0x23cb <-- gone
map 264 at 0x24d4   <-- gone
unmap 264 at 0x24d4 <-- gone
map 264 at 0x263c   <-- gone
unmap 264 at 0x263c <-- gone
map 264 at 0x2746   <-- gone
unmap 264 at 0x2746
map 264 at 0x4043
unmap 264 at 0x4043
map 264 at 0x86f7
unmap 264 at 0x86f7

So going from 19 map/unmap pairs to 5.  Seems like it can't hurt, but
it's a small number either way.

Anyway, I tried your patch and it works for me:

Tested-By: Peter Jones <pjones@redhat.com>

-- 
        Peter


