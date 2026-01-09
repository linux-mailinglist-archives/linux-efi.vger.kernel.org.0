Return-Path: <linux-efi+bounces-5980-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F9D089DE
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E7393064D63
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6243385A3;
	Fri,  9 Jan 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AYGkFnRw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IHUFvxjX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AYGkFnRw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IHUFvxjX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D9338590
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954878; cv=none; b=ELNlo2Dmu8Ajhm3Ba61lzn6xxm2kpP9ezCtYGluAlCjj7+jrZ23aFgWgCjYHMuqPexJ3fvyM5r5kOIrLNEIIaNVRp3dd8t0B/pdaWBV/oBlVCVn/KDGiWRqe11aASn+SwFy7RrPpuI22U4c5FGeqWTijAduOMcO8T0TgLtT8G7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954878; c=relaxed/simple;
	bh=pDV+Y2brq5Y/jlC+k4P9H3Hzq52Ia6LIXFxRhCL7Apk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkAR4iWrY+bJmiECW6bv70VASJlLlT6JO5SfOKT6JvUux5EH5OxgFsL5T2Yk/03E/iazQRQBNQ8L3bygNoL/Gmv+onw7KH1XrufNgeiBlDRr+62E9d2dTuBYYVNcscObPrzAUEU8WZ+GDA27PaOa3pdqU6Pa6wdX/S9eakFjzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AYGkFnRw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IHUFvxjX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AYGkFnRw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IHUFvxjX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 892485BD4C;
	Fri,  9 Jan 2026 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767954869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=quXykmFucH86nMSyArVgl9RjHoQwr+Ungu8b5HjPcy4=;
	b=AYGkFnRwOFEi2fS+0MgdGKuPjA5xML1KOEc0VNsILP7ImaqRJ4uUWXamjRs8/0o0vpKGhf
	7MdEAeqQ4bcAxw2TDloU/+OssmLjWH5UUlO21Va39W6gTXrp1mv9PEbzCDRLA8v7bJkvGC
	fj9pE11XRgdPxIiiCGMLZ4rIU7VzfFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767954869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=quXykmFucH86nMSyArVgl9RjHoQwr+Ungu8b5HjPcy4=;
	b=IHUFvxjXt6RNe94raOnQ1X8PE56K7NAxMjFmxFzfDsr06Ts6Avcj62ovlK3mxFEbcYeb9j
	Lla84MGwl3Bi/IDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767954869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=quXykmFucH86nMSyArVgl9RjHoQwr+Ungu8b5HjPcy4=;
	b=AYGkFnRwOFEi2fS+0MgdGKuPjA5xML1KOEc0VNsILP7ImaqRJ4uUWXamjRs8/0o0vpKGhf
	7MdEAeqQ4bcAxw2TDloU/+OssmLjWH5UUlO21Va39W6gTXrp1mv9PEbzCDRLA8v7bJkvGC
	fj9pE11XRgdPxIiiCGMLZ4rIU7VzfFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767954869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=quXykmFucH86nMSyArVgl9RjHoQwr+Ungu8b5HjPcy4=;
	b=IHUFvxjXt6RNe94raOnQ1X8PE56K7NAxMjFmxFzfDsr06Ts6Avcj62ovlK3mxFEbcYeb9j
	Lla84MGwl3Bi/IDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C7883EA63;
	Fri,  9 Jan 2026 10:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LvUmFbTZYGkGRAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 09 Jan 2026 10:34:28 +0000
Message-ID: <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
Date: Fri, 9 Jan 2026 11:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>,
 Chia-I Wu <olvaffe@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Deepak Rawat <drawat.floss@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
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
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxtqcp3yg5i7i9mi6syp13ijk)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,lists.freedesktop.org,kernel.org,gmail.com,redhat.com,collabora.com,chromium.org,gmx.de,linux.intel.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,lists.freedesktop.org:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi

Am 29.12.25 um 22:58 schrieb Zack Rusin:
> Almost a rite of passage for every DRM developer and most Linux users
> is upgrading your DRM driver/updating boot flags/changing some config
> and having DRM driver fail at probe resulting in a blank screen.
>
> Currently there's no way to recover from DRM driver probe failure. PCI
> DRM driver explicitly throw out the existing sysfb to get exclusive
> access to PCI resources so if the probe fails the system is left without
> a functioning display driver.
>
> Add code to sysfb to recever system framebuffer when DRM driver's probe
> fails. This means that a DRM driver that fails to load reloads the system
> framebuffer driver.
>
> This works best with simpledrm. Without it Xorg won't recover because
> it still tries to load the vendor specific driver which ends up usually
> not working at all. With simpledrm the system recovers really nicely
> ending up with a working console and not a blank screen.
>
> There's a caveat in that some hardware might require some special magic
> register write to recover EFI display. I'd appreciate it a lot if
> maintainers could introduce a temporary failure in their drivers
> probe to validate that the sysfb recovers and they get a working console.
> The easiest way to double check it is by adding:
>   /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
>   dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
>   ret = -EINVAL;
>   goto out_error;
> or such right after the devm_aperture_remove_conflicting_pci_devices .

Recovering the display like that is guess work and will at best work 
with simple discrete devices where the framebuffer is always located in 
a confined graphics aperture.

But the problem you're trying to solve is a real one.

What we'd want to do instead is to take the initial hardware state into 
account when we do the initial mode-setting operation.

The first step is to move each driver's remove_conflicting_devices call 
to the latest possible location in the probe function. We usually do it 
first, because that's easy. But on most hardware, it could happen much 
later. The native driver is free to examine hardware state while probing 
the device as long as it does not interfere with the pre-configured 
framebuffer mode/format/address. Hence it can set up it's internal 
structures while the sysfb device is still active.

The next step for the native driver is to load the pre-configured 
hardware state into its initial internal atomic state. Maxime has worked 
on that on and off. The last iteration I'm aware of is at [1].

After the state-readout, the sysfb device has to be unplugged. But as 
the underlying hardware config remains active, the native driver can now 
use and modify it. We currently do a drm_mode_config_reset(), which 
clears the state and then let the first client set a new display state. 
But with state-readout, we could either pick up the existing framebuffer 
directly or do a proper modeset from existing state.

As DRM clients control the mode setting, they'd likely need some changes 
to handle state-readout. There's such code in i915's fbdev support AFAIK.

Best regards
Thomas

[1] 
https://lore.kernel.org/dri-devel/20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org/

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ce Sun <cesun102@amd.com>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Deepak Rawat <drawat.floss@gmail.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Hans de Goede <hansg@kernel.org>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: nouveau@lists.freedesktop.org
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: spice-devel@lists.freedesktop.org
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Timur Kristóf" <timur.kristof@gmail.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: virtualization@lists.linux.dev
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Zack Rusin (12):
>    video/aperture: Add sysfb restore on DRM probe failure
>    drm/vmwgfx: Use devm aperture helpers for sysfb restore on probe
>      failure
>    drm/xe: Use devm aperture helpers for sysfb restore on probe failure
>    drm/amdgpu: Use devm aperture helpers for sysfb restore on probe
>      failure
>    drm/virtio: Add sysfb restore on probe failure
>    drm/nouveau: Use devm aperture helpers for sysfb restore on probe
>      failure
>    drm/qxl: Use devm aperture helpers for sysfb restore on probe failure
>    drm/vboxvideo: Use devm aperture helpers for sysfb restore on probe
>      failure
>    drm/hyperv: Add sysfb restore on probe failure
>    drm/ast: Use devm aperture helpers for sysfb restore on probe failure
>    drm/radeon: Use devm aperture helpers for sysfb restore on probe
>      failure
>    drm/i915: Use devm aperture helpers for sysfb restore on probe failure
>
>   drivers/firmware/efi/sysfb_efi.c           |   2 +-
>   drivers/firmware/sysfb.c                   | 191 +++++++++++++--------
>   drivers/firmware/sysfb_simplefb.c          |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   7 +
>   drivers/gpu/drm/ast/ast_drv.c              |  13 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c    |  23 +++
>   drivers/gpu/drm/i915/i915_driver.c         |  13 +-
>   drivers/gpu/drm/nouveau/nouveau_drm.c      |  16 +-
>   drivers/gpu/drm/qxl/qxl_drv.c              |  14 +-
>   drivers/gpu/drm/radeon/radeon_drv.c        |  15 +-
>   drivers/gpu/drm/vboxvideo/vbox_drv.c       |  13 +-
>   drivers/gpu/drm/virtio/virtgpu_drv.c       |  29 ++++
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  13 +-
>   drivers/gpu/drm/xe/xe_device.c             |   7 +-
>   drivers/gpu/drm/xe/xe_pci.c                |   7 +
>   drivers/video/aperture.c                   |  54 ++++++
>   include/linux/aperture.h                   |  14 ++
>   include/linux/sysfb.h                      |   6 +
>   19 files changed, 368 insertions(+), 88 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



