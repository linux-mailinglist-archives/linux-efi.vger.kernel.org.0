Return-Path: <linux-efi+bounces-6005-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9AD2DA43
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 09:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3A330FFF2F
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6821FF47;
	Fri, 16 Jan 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R04uVWab";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MZ1Ehz5Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R04uVWab";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MZ1Ehz5Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739D2D77E9
	for <linux-efi@vger.kernel.org>; Fri, 16 Jan 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550313; cv=none; b=uKGaZDBx7K4Fxa4Uh+T4jDAKau0N9NdyXDI7ID0LXgnsDIiwO+rrMSaZy5Czq8CO0T2295uxRSKAros2+Ciu/zx8SWiCn/At6m9VlhWf7iE36PNQEqgEnFtSvjhYFOhL5VLpYeWUlDsOEY6WgPFL02b4PdeX+tDH5Eoh51O488M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550313; c=relaxed/simple;
	bh=kPMwwbbKRxUnQPXfOuJeJCsyQk6k2aZy/J34NNBRuhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/pfcqQcpCXLaPUnbQ1ay9Zp0noryaMqPofWUFj40wLSYnbeUXyhTDIV+AVShMNLvjZyFU8A3BwYdtOEexEw0OBNuYGBliHkhXGId717JDiI8KWIkHQShSfksAjBPmkhgJLL2v8t6U/MUG+7VtlKE4rpWshzpDIdANVHhlIHe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R04uVWab; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MZ1Ehz5Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R04uVWab; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MZ1Ehz5Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB3173368D;
	Fri, 16 Jan 2026 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768550309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tEBnbJXoSEVNx2d1sg+6yp9TJGIDCgDTADCnwPCP7K0=;
	b=R04uVWabAymZykGlX+71SwYrLQ6fCzyjOgy+9ATKoaBXltpvMrjIlYpv5Q3yl4hyqJQqQk
	ic0hgpJzRhcu/XCONdInAYct22wQf9B2hRKDGAhcBsOhViR6cCBFk0lM9YwDMZwWYtbOhZ
	3CIEsweVt1ZK6QNpJiQvBRvHy9sHwyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768550309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tEBnbJXoSEVNx2d1sg+6yp9TJGIDCgDTADCnwPCP7K0=;
	b=MZ1Ehz5YNpca9ytNX4G/92HJJlPCJPBDy2lqLRB9ZcbIoy5+YWZTdll3DfwqPiZkbmZXaV
	ibH4XxwwepxK2qBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768550309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tEBnbJXoSEVNx2d1sg+6yp9TJGIDCgDTADCnwPCP7K0=;
	b=R04uVWabAymZykGlX+71SwYrLQ6fCzyjOgy+9ATKoaBXltpvMrjIlYpv5Q3yl4hyqJQqQk
	ic0hgpJzRhcu/XCONdInAYct22wQf9B2hRKDGAhcBsOhViR6cCBFk0lM9YwDMZwWYtbOhZ
	3CIEsweVt1ZK6QNpJiQvBRvHy9sHwyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768550309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tEBnbJXoSEVNx2d1sg+6yp9TJGIDCgDTADCnwPCP7K0=;
	b=MZ1Ehz5YNpca9ytNX4G/92HJJlPCJPBDy2lqLRB9ZcbIoy5+YWZTdll3DfwqPiZkbmZXaV
	ibH4XxwwepxK2qBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF64F3EA63;
	Fri, 16 Jan 2026 07:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gp4oKaTvaWk8ZAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Jan 2026 07:58:28 +0000
Message-ID: <f3643c19-c250-4927-b39d-37d2494c7c84@suse.de>
Date: Fri, 16 Jan 2026 08:58:28 +0100
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
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <CABQX2QMn_dTh2h44LRwB7+RxGqK3Jn+QCx38xWrzpNJG5SZ9-Q@mail.gmail.com>
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
In-Reply-To: <CABQX2QMn_dTh2h44LRwB7+RxGqK3Jn+QCx38xWrzpNJG5SZ9-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,kernel.org,gmail.com,redhat.com,collabora.com,chromium.org,gmx.de,linux.intel.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url]
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 16.01.26 um 04:59 schrieb Zack Rusin:
> On Thu, Jan 15, 2026 at 6:02 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> That's really not going to work. For example, in the current series, you
>> invoke devm_aperture_remove_conflicting_pci_devices_done() after
>> drm_mode_reset(), drm_dev_register() and drm_client_setup().
> That's perfectly fine,
> devm_aperture_remove_conflicting_pci_devices_done is removing the
> reload behavior not doing anything.
>
> This series, essentially, just adds a "defer" statement to
> aperture_remove_conflicting_pci_devices that says
>
> "reload sysfb if this driver unloads".
>
> devm_aperture_remove_conflicting_pci_devices_done just cancels that defer.

Exactly. And if that reload happens after the hardware state has been 
changed, the result is undefined.

>
> You could ask why have
> devm_aperture_remove_conflicting_pci_devices_done at all then and it's
> because I didn't want to change the default behavior of anything.
>
> There are three cases:
> 1) Driver fails to load before
> aperture_remove_conflicting_pci_devices, in which case sysfb is still
> active and there's no problem,
> 2) Driver fails to load after aperture_remove_conflicting_pci_devices,
> in which case sysfb is gone and the screen is blank
> 3) Driver is unloaded after the probe succeeded. igt tests this too.
>
> Without devm_aperture_remove_conflicting_pci_devices_done we'd try to
> reload sysfb in #3, which, in general makes sense to me and I'd
> probably remove it in my drivers, but there might be people or tests
> (again, igt does it and we don't need to flip-flop between sysfb and
> the driver there) that depend on specifically that behavior of not
> having anything driving fb so I didn't want to change it.
>
> So with this series the worst case scenario is that the driver that
> failed after aperture_remove_conflicting_pci_devices changed the
> hardware state so much that sysfb can't recover and the fb is blank.
> So it was blank before and this series can't fix it because the driver
> in its cleanup routine will need to do more unwinding for sysfb to
> reload (i.e. we'd need an extra patch to unwind the driver state).

The current recovery/reload is not reliable in any case. A number of 
high-profile devs have also said that it doesn't work with their driver. 
The same is true for ast. So the current approach is not going to happen.

> There also might be the case of some crazy behavior, e.g. pci bar
> resize in the driver makes the vga hardware crash or something, in
> which case, yea, we should definitely skip this patch, at least until
> those drivers properly cleanup on exit.

There's nothing crazy here. It's standard probing code.

If you want to to move forward, my suggestion is to look at the proposal 
with the aperture_funcs callbacks that control sysfb device access. And 
from there, build a full prototype with one or two drivers.

Best regards
Thomas


>
> z

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



