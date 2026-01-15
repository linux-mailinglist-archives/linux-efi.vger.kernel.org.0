Return-Path: <linux-efi+bounces-5993-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1BBD240A6
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 12:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA46301F8CC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132E3563ED;
	Thu, 15 Jan 2026 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nxqUG7n/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K7VwqNzq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2SUUTLsr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mGIcw6rx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900832AAD4
	for <linux-efi@vger.kernel.org>; Thu, 15 Jan 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474958; cv=none; b=VtYQnMaPkBX9lNSzF/kp3KUixsGLQPwb902W4Do4KGeVOMmYVt/guaPIrJuNeXWUzIx3PFdPlgDWq2eLDimX8KVjrC+QHRqkWrR3VuNBb86+PUOGHdApxgD84OTfMxCF+F0z55ozFYaSwBKzxCIpvq+Z9DDoxHFRDKAmOZsqTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474958; c=relaxed/simple;
	bh=5/JKTh6Xlt7PShWnhEovAHtyYHCz60xWaDVvNiy3l7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHKy+ZajgEANiSrYNX+BJGuEAuhVFIq85P/md73n3qczvgl3Ap1gSdepmfnYfprG5COF1/j3dPK4YtrhscDP+QPSNFCX3n/o53oHQpjshj8SBWWN5y2SNXA/ADR2Ax6WfGZ8IDlZdzk5W4fDrcFAUzGmsQXrM/AeFmqUOS7Qf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nxqUG7n/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K7VwqNzq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2SUUTLsr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mGIcw6rx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF8933368D;
	Thu, 15 Jan 2026 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768474955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b1iB/X+y4KnDjsmYQDJWINso6ydXpMkq0JbeHKY3Meo=;
	b=nxqUG7n/Ba/Vk3Vqbkd8x5uE/t4wEWS544KTjenz2rOM0peNllN0a38ZWieXEOZ1ZFou0L
	lN6udrw2wxFodxzeU9E9PsRCWhP4U8rDt1q4rvJYNkUEUXjHx2C7auuV9IxYSy2PvcZIm9
	NjPSz1C/ie8PgZ8Ez7FIU3l3L6zAtTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768474955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b1iB/X+y4KnDjsmYQDJWINso6ydXpMkq0JbeHKY3Meo=;
	b=K7VwqNzq0jmKB/Hg2XSEsg4X9oh1lKMI5p9DaxDa720VTsrHC7IGQQZLAIfYFsjYSIv4YC
	T1EcWnuTzsT7ZPAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768474954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b1iB/X+y4KnDjsmYQDJWINso6ydXpMkq0JbeHKY3Meo=;
	b=2SUUTLsrsfMv42Ft91rhkIDo2rk92wh538czRVUyYyhaujd4nQVEYC8liZ8OzrzjT70MFV
	yVqAUmNhn40Aym9gonJ+CxaNA6RsLfJBjWJ/ek9BvP2iwk5qhk8+3NYMy8YnVdRezxE6VX
	XQDyRuG98TpqmGHwggqedCHdzatVedQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768474954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b1iB/X+y4KnDjsmYQDJWINso6ydXpMkq0JbeHKY3Meo=;
	b=mGIcw6rx1saRlGWP8hEX15UAN8hPBMuYD4JhTqBQKI5gC/C8zxyomKzetVtgeitnCQ0pI0
	/0WXUfg85ko2azDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAFBB3EA63;
	Thu, 15 Jan 2026 11:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqgBNEnJaGnnJQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 15 Jan 2026 11:02:33 +0000
Message-ID: <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
Date: Thu, 15 Jan 2026 12:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
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
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
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
In-Reply-To: <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,kernel.org,gmail.com,redhat.com,collabora.com,chromium.org,gmx.de,linux.intel.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi,

apologies for the delay. I wanted to reply and then forgot about it.

Am 10.01.26 um 05:52 schrieb Zack Rusin:
> On Fri, Jan 9, 2026 at 5:34 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 29.12.25 um 22:58 schrieb Zack Rusin:
>>> Almost a rite of passage for every DRM developer and most Linux users
>>> is upgrading your DRM driver/updating boot flags/changing some config
>>> and having DRM driver fail at probe resulting in a blank screen.
>>>
>>> Currently there's no way to recover from DRM driver probe failure. PCI
>>> DRM driver explicitly throw out the existing sysfb to get exclusive
>>> access to PCI resources so if the probe fails the system is left without
>>> a functioning display driver.
>>>
>>> Add code to sysfb to recever system framebuffer when DRM driver's probe
>>> fails. This means that a DRM driver that fails to load reloads the system
>>> framebuffer driver.
>>>
>>> This works best with simpledrm. Without it Xorg won't recover because
>>> it still tries to load the vendor specific driver which ends up usually
>>> not working at all. With simpledrm the system recovers really nicely
>>> ending up with a working console and not a blank screen.
>>>
>>> There's a caveat in that some hardware might require some special magic
>>> register write to recover EFI display. I'd appreciate it a lot if
>>> maintainers could introduce a temporary failure in their drivers
>>> probe to validate that the sysfb recovers and they get a working console.
>>> The easiest way to double check it is by adding:
>>>    /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
>>>    dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
>>>    ret = -EINVAL;
>>>    goto out_error;
>>> or such right after the devm_aperture_remove_conflicting_pci_devices .
>> Recovering the display like that is guess work and will at best work
>> with simple discrete devices where the framebuffer is always located in
>> a confined graphics aperture.
>>
>> But the problem you're trying to solve is a real one.
>>
>> What we'd want to do instead is to take the initial hardware state into
>> account when we do the initial mode-setting operation.
>>
>> The first step is to move each driver's remove_conflicting_devices call
>> to the latest possible location in the probe function. We usually do it
>> first, because that's easy. But on most hardware, it could happen much
>> later.
> Well, some drivers (vbox, vmwgfx, bochs and currus-qemu) do it because
> they request pci regions which is going to fail otherwise. Because
> grabbining the pci resources is in general the very first thing that
> those drivers need to do to setup anything, we
> remove_conflicting_devices first or at least very early.

To my knowledge, requesting resources is more about correctness than a 
hard requirement to use an I/O or memory range. Has this changed?


>
> I also don't think it's possible or even desirable by some drivers to
> reuse the initial state, good example here is vmwgfx where by default
> some people will setup their vm's with e.g. 8mb ram, when the vmwgfx
> loads we allow scanning out from system memory, so you can set your vm
> up with 8mb of vram but still use 4k resolutions when the driver
> loads, this way the suspend size of the vm is very predictable (tiny
> vram plus whatever ram was setup) while still allowing a lot of
> flexibility.

If there's no initial state to switch from, the first modeset can fail 
while leaving the display unusable. There's no way around that. Going 
back to the old state is not an option unless the driver has been 
written to support this.

The case of vmwgfx is special, but does not effect the overall problem. 
For vmwgfx, it would be best to import that initial state and support a 
transparent modeset from vram to system memory (and back) at least 
during this initial state.


>
> In general I think however this is planned it's two or three separate series:
> 1) infrastructure to reload the sysfb driver (what this series is)
> 2) making sure that drivers that do want to recover cleanly actually
> clean out all the state on exit properly,
> 3) abstracting at least some of that cleanup in some driver independent way

That's really not going to work. For example, in the current series, you 
invoke devm_aperture_remove_conflicting_pci_devices_done() after 
drm_mode_reset(), drm_dev_register() and drm_client_setup(). Each of 
these calls can modify hardware state. In the case of _register() and 
_setup(), the DRM clients can perform a modeset, which destroys the 
initial hardware state. Patch 1 of this series removes the sysfb 
device/driver entirely. That should be a no-go as it significantly 
complicates recovery. For example, if the native drivers failed from an 
allocation failure, the sysfb device/driver is not likely to come back 
either. As the very first thing, the series should state which failures 
is is going to resolve, - failed hardware init, - invalid initial 
modesetting, - runtime errors (such ENOMEM, failed firmware loading), - 
others? And then specify how a recovery to sysfb could look in each 
supported scenario. In terms of implementation, make any transition 
between drivers gradually. The native driver needs to acquire the 
hardware resource (framebuffer and I/O apertures) without unloading the 
sysfb driver. Luckily there's struct drm_device.unplug, which does that. 
[1] Flipping this field disables hardware access for DRM drivers. All 
sysfb drivers support this. To get the sysfb drivers ready, I suggest 
dedicated helpers for each drivers aperture. The aperture helpers can 
use these callback to flip the DRM driver off and on again. For example, 
efidrm could do this as a minimum: int efidrm_aperture_suspend() { 
dev->unplug = true; remove_resource(/*framebuffer aperture*/) return 0 } 
int efidrm_aperture_resume() { insert_resource(/*framebuffer aperture*/) 
dev->unplug = false; return 0 } struct aperture_funcs 
efidrm_aperture_funcs { .suspend = efidrm_aperture_suspend, .resume = 
efidrm_aperture_resume, } Pass this struct when efidrm acquires the 
framebuffer aperture, so that the aperture helpers can control the 
behavior of efidrm. With this, a multi-step takeover from sysfb to 
native driver can be tried. It's still a massive effort that requires an 
audit of each driver's probing logic. There's no copy-paste pattern 
AFAICT. I suggest to pick one simple driver first and make a prototype. 
Let me also say that I DO like the general idea you're proposing. But if 
it was easy, we would likely have done it already. Best regards Thomas
>
> z

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



