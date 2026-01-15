Return-Path: <linux-efi+bounces-5999-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3154D25CD7
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CAF30424B4
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF63B9619;
	Thu, 15 Jan 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajgs/5uV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F73B8D70;
	Thu, 15 Jan 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495201; cv=none; b=kxQDhA6Tk2Q+/r5W0Q673Y9I3pnKo1iinf1qntvkff8fqEOeG4HaHqAG+xcf7uoX5sygJyMrocTDMbvksARXztjPEQCO9Z4z8RbA8wc9YAB+bxDfAO0t21PbKmFc5FsgsjgIvtgdbq/T9TPdHLHMPxc1GdFPYRAdRNDCMcDG8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495201; c=relaxed/simple;
	bh=m/Qx1m1mblaNipkWax3IZgERtuZ8Zkg6ma1HJe/Md/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8tiACoGk6fYwuhSgE0f0sbZpYB+JCiJMADC2h9cdboKXIZS0hDg74r9TT8e1PMYBdTFzzUQS49t/b3kkRU81Eg6Vv9qtXIDtTzZke1DNNoFx32XTgOf3kzJfMVvZLgsf6CJ8dSyre+wMzJGp+z1sMmf1iNWiEDcn84wekL4BoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajgs/5uV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE65FC116D0;
	Thu, 15 Jan 2026 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768495201;
	bh=m/Qx1m1mblaNipkWax3IZgERtuZ8Zkg6ma1HJe/Md/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ajgs/5uVyXu7H8VC4ngrms4uARgCVFYOon/i7wj+tn1w72j7H9T4CM/BxlZwd5lfS
	 ArM+/+rYU3rKnLV6+pVVvz2xEyrpoFlBKWFw0boo3efTETsCmzQu/ZE0OeVtl0dB+f
	 OsIA6BVINFZuD/IWhl5QhJw7xQ/V3+KuhWleDmm2Uu0LE4mBpC5uY2z5TWKQR60521
	 okmZ3GiKI4O0OQKRcKN8BhBRretfYIV+o+nSHwdJyyofS2pOTXfPpeZVnq7A8/4fqQ
	 5muGt/pK+Fzt9ilSvbB4X7VBJVKErM24M547oE1T0H0ecZk5Yym+Nzm5jURgtti7jE
	 zgal0OGtjOvSg==
Message-ID: <c78e9794-e63f-47f9-a4cb-e3b5625ab828@kernel.org>
Date: Thu, 15 Jan 2026 10:39:56 -0600
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zack Rusin
 <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Deepak Rawat <drawat.floss@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Helge Deller <deller@gmx.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com> <aWkDYO1o9T1BhvXj@intel.com>
 <aWkWSnJ7Xn6ukW-b@sirius.home.kraxel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aWkWSnJ7Xn6ukW-b@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 10:36 AM, Gerd Hoffmann wrote:
>    Hi,
> 
>>> At least for AMD GPUs remove_conflicting_devices() really early is
>>> necessary because otherwise some operations just result in a
>>> spontaneous system reboot.	
> 
>> It's similar for Intel. For us VGA emulation won't be used for EFI
>> boot, but we still can't have the previous driver poking around in
>> memory while the real driver is initializing. The entire memory layout
>> may get completely shuffled so there's no telling where such memory
>> accesses would land.
> 
> Can you do stuff like checking which firmware is needed and whenever
> that can be loaded from the filesystem before calling
> remove_conflicting_devices() ?
> 

That's something that I did in amdgpu a few years back.

I pushed the identification and ability to load firmware into early init 
stages.  It means that if you have a brand new GPU and run a modern 
kernel with an older linux-firmware snapshot amdgpu will fail probe and 
your framebuffer from EFI keeps working.

