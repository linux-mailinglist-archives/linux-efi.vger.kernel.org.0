Return-Path: <linux-efi+bounces-5998-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80FD25C7D
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D0B30341EF
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE313B960F;
	Thu, 15 Jan 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JONOyomE"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B953BB9FE
	for <linux-efi@vger.kernel.org>; Thu, 15 Jan 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495019; cv=none; b=EZLOYzKCnIVUDq79UV6Exl5yxthbXDZnxkD98rbHSiSsfKqPQ97rC/0TxBy4fIscOH0hSwuGDjk28Z+UNa8Gtjbii16l2QJ/kZc5juYMD6AGprUp4yb4Z8Ml40GheNaCuGXyuwxxxEHI7PZ3vz3byI425aGqbzaTfdFz086AE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495019; c=relaxed/simple;
	bh=TDvZ1Kq1fcXLktDE/bWq1SlMPyVyzj14orm+JLgrBho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGr3+Xu920KaMzXJ7ontqXR6iJs+P5yaPZiMXKHAy0sc/EfM8ib9bh+osRaNSHiGVzumnJAcwBPTMkqZyfM0kNLfhCDv3uodmtuLPASStC2pXm/1eSDym8DC/7N8lPRZMArVTZmiJHH3/4lh4Rez7Ht6fXR7zZ29sW7FPnUEpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JONOyomE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768495016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YapI6yvvFKBlNsIuFY3dURmJ8ly4nR9lByNbPeI57Wk=;
	b=JONOyomEONWEcGNeF9+MXHKupDiteIjiXNrvLIb5Tw057YdDS4Cmvdn7cwDAbcxAs3rETe
	oZL/1V3TXHpAUaCk/J5nobqF57sQDAdpvq/PX5/iokcE449cxcfl+bipao/74NyUpprQvl
	7nrRGlc3xmKDCWLeGlq6/SOlubBd7fc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-EF4CM8dfMF-Md1jPR3oF-A-1; Thu,
 15 Jan 2026 11:36:53 -0500
X-MC-Unique: EF4CM8dfMF-Md1jPR3oF-A-1
X-Mimecast-MFC-AGG-ID: EF4CM8dfMF-Md1jPR3oF-A_1768495009
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD6D7180035D;
	Thu, 15 Jan 2026 16:36:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFC961955F22;
	Thu, 15 Jan 2026 16:36:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 9866C18483A0; Thu, 15 Jan 2026 17:36:43 +0100 (CET)
Date: Thu, 15 Jan 2026 17:36:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Zack Rusin <zack.rusin@broadcom.com>, 
	dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Dave Airlie <airlied@redhat.com>, Deepak Rawat <drawat.floss@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Helge Deller <deller@gmx.de>, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Maxime Ripard <mripard@kernel.org>, 
	nouveau@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Simona Vetter <simona@ffwll.ch>, spice-devel@lists.freedesktop.org, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
Message-ID: <aWkWSnJ7Xn6ukW-b@sirius.home.kraxel.org>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
 <aWkDYO1o9T1BhvXj@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkDYO1o9T1BhvXj@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

  Hi,

> > At least for AMD GPUs remove_conflicting_devices() really early is
> > necessary because otherwise some operations just result in a
> > spontaneous system reboot.	

> It's similar for Intel. For us VGA emulation won't be used for EFI
> boot, but we still can't have the previous driver poking around in
> memory while the real driver is initializing. The entire memory layout
> may get completely shuffled so there's no telling where such memory
> accesses would land.

Can you do stuff like checking which firmware is needed and whenever
that can be loaded from the filesystem before calling
remove_conflicting_devices() ?

take care,
  Gerd


