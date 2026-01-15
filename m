Return-Path: <linux-efi+bounces-5995-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1AD25227
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E7103083A8F
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2813A1E63;
	Thu, 15 Jan 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3+AdunZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+y469f0k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3+AdunZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+y469f0k"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95643A1E7C
	for <linux-efi@vger.kernel.org>; Thu, 15 Jan 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488865; cv=none; b=Bafh3LoFxQKatc9YWYODpjfJ8sad6f1DA2jT2r2OFIrGqMJwb8w6VtZxJmEa+Bxp184P5Kl8gyLeXxdba4NsEJ0uB8ARMGrxvmlcYUO8jS1+IdHc6qn2j+9n/2Dd/s0Ayk+YiIwiqt77mV00YU1yt46266ITu0F5hng/FfhCf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488865; c=relaxed/simple;
	bh=JZZ4aQNg2kjiPEymub4m2ZNUq8Vs0R8IU8wf9bayzIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfrV/dk1W3844Y59yetvsuL16sIxBK9flwoUS8hYQ22UfTmXMDfr7cPXvPky49B4TrFLt1DlroRcSXuCaS6KozjU20U9C8z2RT8G3dV5V+hZX7DTd9Nu/e+8uo7UqMBG0Ho1TuzGHG9UseUPEI4fbRjN4gniDNlwmGiY6WwuIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3+AdunZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+y469f0k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3+AdunZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+y469f0k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C8345BCF9;
	Thu, 15 Jan 2026 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768488861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JZZ4aQNg2kjiPEymub4m2ZNUq8Vs0R8IU8wf9bayzIQ=;
	b=u3+AdunZbEIUoZWB+rhqLpYJ6IOEXlrbfM2JOkCyI5MYIcDLrEuH8P0Cesm86n4ZwEyDAa
	uwkCa8FFBhp5oqidCwb4Vc3vWyffObhGGihTxKkp4BHJt0G2R3PUONHXQYb1qaEVhoifKv
	3Ts9xhU9N5+rdU9u8xuq+XZTAT10uH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768488861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JZZ4aQNg2kjiPEymub4m2ZNUq8Vs0R8IU8wf9bayzIQ=;
	b=+y469f0kxCy5vqopXjNK/p7mIWTHY+kTTMW2/4AAvaaIVWS0yxnWyT2vCR37a2/fCUpjx7
	EgGAVex9oJIKDYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768488861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JZZ4aQNg2kjiPEymub4m2ZNUq8Vs0R8IU8wf9bayzIQ=;
	b=u3+AdunZbEIUoZWB+rhqLpYJ6IOEXlrbfM2JOkCyI5MYIcDLrEuH8P0Cesm86n4ZwEyDAa
	uwkCa8FFBhp5oqidCwb4Vc3vWyffObhGGihTxKkp4BHJt0G2R3PUONHXQYb1qaEVhoifKv
	3Ts9xhU9N5+rdU9u8xuq+XZTAT10uH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768488861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JZZ4aQNg2kjiPEymub4m2ZNUq8Vs0R8IU8wf9bayzIQ=;
	b=+y469f0kxCy5vqopXjNK/p7mIWTHY+kTTMW2/4AAvaaIVWS0yxnWyT2vCR37a2/fCUpjx7
	EgGAVex9oJIKDYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 066063EA63;
	Thu, 15 Jan 2026 14:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lYw6AJz/aGlHAQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 15 Jan 2026 14:54:20 +0000
Message-ID: <4ee824d5-8ea0-4ae1-8bcb-5f8cbae37fc8@suse.de>
Date: Thu, 15 Jan 2026 15:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
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
 <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
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
In-Reply-To: <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Score: -2.70
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,kernel.org,gmail.com,redhat.com,collabora.com,chromium.org,gmx.de,linux.intel.com,vger.kernel.org,intel.com,ffwll.ch,ursulin.net,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxtqcp3yg5i7i9mi6syp13ijk)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO

SGkNCg0KQW0gMTUuMDEuMjYgdW0gMTU6Mzkgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOg0K
PiBTb3JyeSB0byBiZWluZyBsYXRlLCBidXQgSSBvbmx5IG5vdyByZWFsaXplZCB3aGF0IHlv
dSBhcmUgZG9pbmcgaGVyZS4NCj4NCj4gT24gMS8xNS8yNiAxMjowMiwgVGhvbWFzIFppbW1l
cm1hbm4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBhcG9sb2dpZXMgZm9yIHRoZSBkZWxheS4g
SSB3YW50ZWQgdG8gcmVwbHkgYW5kIHRoZW4gZm9yZ290IGFib3V0IGl0Lg0KPj4NCj4+IEFt
IDEwLjAxLjI2IHVtIDA1OjUyIHNjaHJpZWIgWmFjayBSdXNpbjoNCj4+PiBPbiBGcmksIEph
biA5LCAyMDI2IGF0IDU6MzTigK9BTSBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4gd3JvdGU6DQo+Pj4+IEhpDQo+Pj4+DQo+Pj4+IEFtIDI5LjEyLjI1IHVtIDIy
OjU4IHNjaHJpZWIgWmFjayBSdXNpbjoNCj4+Pj4+IEFsbW9zdCBhIHJpdGUgb2YgcGFzc2Fn
ZSBmb3IgZXZlcnkgRFJNIGRldmVsb3BlciBhbmQgbW9zdCBMaW51eCB1c2Vycw0KPj4+Pj4g
aXMgdXBncmFkaW5nIHlvdXIgRFJNIGRyaXZlci91cGRhdGluZyBib290IGZsYWdzL2NoYW5n
aW5nIHNvbWUgY29uZmlnDQo+Pj4+PiBhbmQgaGF2aW5nIERSTSBkcml2ZXIgZmFpbCBhdCBw
cm9iZSByZXN1bHRpbmcgaW4gYSBibGFuayBzY3JlZW4uDQo+Pj4+Pg0KPj4+Pj4gQ3VycmVu
dGx5IHRoZXJlJ3Mgbm8gd2F5IHRvIHJlY292ZXIgZnJvbSBEUk0gZHJpdmVyIHByb2JlIGZh
aWx1cmUuIFBDSQ0KPj4+Pj4gRFJNIGRyaXZlciBleHBsaWNpdGx5IHRocm93IG91dCB0aGUg
ZXhpc3Rpbmcgc3lzZmIgdG8gZ2V0IGV4Y2x1c2l2ZQ0KPj4+Pj4gYWNjZXNzIHRvIFBDSSBy
ZXNvdXJjZXMgc28gaWYgdGhlIHByb2JlIGZhaWxzIHRoZSBzeXN0ZW0gaXMgbGVmdCB3aXRo
b3V0DQo+Pj4+PiBhIGZ1bmN0aW9uaW5nIGRpc3BsYXkgZHJpdmVyLg0KPj4+Pj4NCj4+Pj4+
IEFkZCBjb2RlIHRvIHN5c2ZiIHRvIHJlY2V2ZXIgc3lzdGVtIGZyYW1lYnVmZmVyIHdoZW4g
RFJNIGRyaXZlcidzIHByb2JlDQo+Pj4+PiBmYWlscy4gVGhpcyBtZWFucyB0aGF0IGEgRFJN
IGRyaXZlciB0aGF0IGZhaWxzIHRvIGxvYWQgcmVsb2FkcyB0aGUgc3lzdGVtDQo+Pj4+PiBm
cmFtZWJ1ZmZlciBkcml2ZXIuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyB3b3JrcyBiZXN0IHdpdGgg
c2ltcGxlZHJtLiBXaXRob3V0IGl0IFhvcmcgd29uJ3QgcmVjb3ZlciBiZWNhdXNlDQo+Pj4+
PiBpdCBzdGlsbCB0cmllcyB0byBsb2FkIHRoZSB2ZW5kb3Igc3BlY2lmaWMgZHJpdmVyIHdo
aWNoIGVuZHMgdXAgdXN1YWxseQ0KPj4+Pj4gbm90IHdvcmtpbmcgYXQgYWxsLiBXaXRoIHNp
bXBsZWRybSB0aGUgc3lzdGVtIHJlY292ZXJzIHJlYWxseSBuaWNlbHkNCj4+Pj4+IGVuZGlu
ZyB1cCB3aXRoIGEgd29ya2luZyBjb25zb2xlIGFuZCBub3QgYSBibGFuayBzY3JlZW4uDQo+
Pj4+Pg0KPj4+Pj4gVGhlcmUncyBhIGNhdmVhdCBpbiB0aGF0IHNvbWUgaGFyZHdhcmUgbWln
aHQgcmVxdWlyZSBzb21lIHNwZWNpYWwgbWFnaWMNCj4+Pj4+IHJlZ2lzdGVyIHdyaXRlIHRv
IHJlY292ZXIgRUZJIGRpc3BsYXkuIEknZCBhcHByZWNpYXRlIGl0IGEgbG90IGlmDQo+Pj4+
PiBtYWludGFpbmVycyBjb3VsZCBpbnRyb2R1Y2UgYSB0ZW1wb3JhcnkgZmFpbHVyZSBpbiB0
aGVpciBkcml2ZXJzDQo+Pj4+PiBwcm9iZSB0byB2YWxpZGF0ZSB0aGF0IHRoZSBzeXNmYiBy
ZWNvdmVycyBhbmQgdGhleSBnZXQgYSB3b3JraW5nIGNvbnNvbGUuDQo+Pj4+PiBUaGUgZWFz
aWVzdCB3YXkgdG8gZG91YmxlIGNoZWNrIGl0IGlzIGJ5IGFkZGluZzoNCj4+Pj4+ICDCoMKg
IC8qIFhYWDogVGVtcG9yYXJ5IGZhaWx1cmUgdG8gdGVzdCBzeXNmYiByZXN0b3JlIC0gUkVN
T1ZFIEJFRk9SRSBDT01NSVQgKi8NCj4+Pj4+ICDCoMKgIGRldl9pbmZvKCZwZGV2LT5kZXYs
ICJUZXN0aW5nIHN5c2ZiIHJlc3RvcmU6IGZvcmNpbmcgcHJvYmUgZmFpbHVyZVxuIik7DQo+
Pj4+PiAgwqDCoCByZXQgPSAtRUlOVkFMOw0KPj4+Pj4gIMKgwqAgZ290byBvdXRfZXJyb3I7
DQo+Pj4+PiBvciBzdWNoIHJpZ2h0IGFmdGVyIHRoZSBkZXZtX2FwZXJ0dXJlX3JlbW92ZV9j
b25mbGljdGluZ19wY2lfZGV2aWNlcyAuDQo+Pj4+IFJlY292ZXJpbmcgdGhlIGRpc3BsYXkg
bGlrZSB0aGF0IGlzIGd1ZXNzIHdvcmsgYW5kIHdpbGwgYXQgYmVzdCB3b3JrDQo+Pj4+IHdp
dGggc2ltcGxlIGRpc2NyZXRlIGRldmljZXMgd2hlcmUgdGhlIGZyYW1lYnVmZmVyIGlzIGFs
d2F5cyBsb2NhdGVkIGluDQo+Pj4+IGEgY29uZmluZWQgZ3JhcGhpY3MgYXBlcnR1cmUuDQo+
Pj4+DQo+Pj4+IEJ1dCB0aGUgcHJvYmxlbSB5b3UncmUgdHJ5aW5nIHRvIHNvbHZlIGlzIGEg
cmVhbCBvbmUuDQo+Pj4+DQo+Pj4+IFdoYXQgd2UnZCB3YW50IHRvIGRvIGluc3RlYWQgaXMg
dG8gdGFrZSB0aGUgaW5pdGlhbCBoYXJkd2FyZSBzdGF0ZSBpbnRvDQo+Pj4+IGFjY291bnQg
d2hlbiB3ZSBkbyB0aGUgaW5pdGlhbCBtb2RlLXNldHRpbmcgb3BlcmF0aW9uLg0KPj4+Pg0K
Pj4+PiBUaGUgZmlyc3Qgc3RlcCBpcyB0byBtb3ZlIGVhY2ggZHJpdmVyJ3MgcmVtb3ZlX2Nv
bmZsaWN0aW5nX2RldmljZXMgY2FsbA0KPj4+PiB0byB0aGUgbGF0ZXN0IHBvc3NpYmxlIGxv
Y2F0aW9uIGluIHRoZSBwcm9iZSBmdW5jdGlvbi4gV2UgdXN1YWxseSBkbyBpdA0KPj4+PiBm
aXJzdCwgYmVjYXVzZSB0aGF0J3MgZWFzeS4gQnV0IG9uIG1vc3QgaGFyZHdhcmUsIGl0IGNv
dWxkIGhhcHBlbiBtdWNoDQo+Pj4+IGxhdGVyLg0KPj4+IFdlbGwsIHNvbWUgZHJpdmVycyAo
dmJveCwgdm13Z2Z4LCBib2NocyBhbmQgY3VycnVzLXFlbXUpIGRvIGl0IGJlY2F1c2UNCj4+
PiB0aGV5IHJlcXVlc3QgcGNpIHJlZ2lvbnMgd2hpY2ggaXMgZ29pbmcgdG8gZmFpbCBvdGhl
cndpc2UuIEJlY2F1c2UNCj4+PiBncmFiYmluaW5nIHRoZSBwY2kgcmVzb3VyY2VzIGlzIGlu
IGdlbmVyYWwgdGhlIHZlcnkgZmlyc3QgdGhpbmcgdGhhdA0KPj4+IHRob3NlIGRyaXZlcnMg
bmVlZCB0byBkbyB0byBzZXR1cCBhbnl0aGluZywgd2UNCj4+PiByZW1vdmVfY29uZmxpY3Rp
bmdfZGV2aWNlcyBmaXJzdCBvciBhdCBsZWFzdCB2ZXJ5IGVhcmx5Lg0KPj4gVG8gbXkga25v
d2xlZGdlLCByZXF1ZXN0aW5nIHJlc291cmNlcyBpcyBtb3JlIGFib3V0IGNvcnJlY3RuZXNz
IHRoYW4gYSBoYXJkIHJlcXVpcmVtZW50IHRvIHVzZSBhbiBJL08gb3IgbWVtb3J5IHJhbmdl
LiBIYXMgdGhpcyBjaGFuZ2VkPw0KPiBOb3BlIHRoYXQgaXMgbm90IGNvcnJlY3QuDQo+DQo+
IEF0IGxlYXN0IGZvciBBTUQgR1BVcyByZW1vdmVfY29uZmxpY3RpbmdfZGV2aWNlcygpIHJl
YWxseSBlYXJseSBpcyBuZWNlc3NhcnkgYmVjYXVzZSBvdGhlcndpc2Ugc29tZSBvcGVyYXRp
b25zIGp1c3QgcmVzdWx0IGluIGEgc3BvbnRhbmVvdXMgc3lzdGVtIHJlYm9vdC4JDQoNCkhl
cmUgSSB3YXMgb25seSB0YWxraW5nIGFib3V0IGF2b2lkaW5nIGNhbGxzIHRvIHJlcXVlc3Rf
cmVzb3VyY2UoKSBhbmQgDQpzaW1pbGFyIGludGVyZmFjZXMuDQoNCj4NCj4gRm9yIGV4YW1w
bGUgcmVzaXppbmcgdGhlIFBDSWUgQkFSIGdpdmluZyBhY2Nlc3MgdG8gVlJBTSBvciBkaXNh
YmxpbmcgVkdBIGVtdWxhdGlvbiAod2hpY2ggQUZBSUsgaXMgdXNlZCBmb3IgRUZJIGFzIHdl
bGwpIGlzIG9ubHkgcG9zc2libGUgd2hlbiB0aGUgVkdBIG9yIEVGSSBmcmFtZWJ1ZmZlciBk
cml2ZXIgaXMga2lja2VkIG91dCBmaXJzdC4NCg0KWWVhaCwgdGhhdCdzIHdoYXQgSSBleHBl
Y3RlZC4NCg0KPg0KPiBBbmQgZGlzYWJsaW5nIFZHQSBlbXVsYXRpb24gaXMgYW1vbmcgdGhl
IGFic29sdXRlbHkgZmlyc3Qgc3RlcHMgeW91IGRvIHRvIHRha2Ugb3ZlciB0aGUgc2Nhbm91
dCBjb25maWcuDQoNCkFzc3VtaW5nIHRoZSBkcml2ZXIgKG9yIGRyaXZlciBhdXRob3IpIGlz
IGNhcmVmdWwsIGlzIGl0IHBvc3NpYmxlIHRvIA0Kb25seSByZWFkIHN0YXRlIGZyb20gQU1E
IGhhcmR3YXJlIGF0IHN1Y2ggYW4gZWFybHkgdGltZT8NCg0KV2UgdXN1YWxseSBkbyByZW1v
dmVfY29uZmxpY3RpbmdfZGV2aWNlcygpIGFzIHRoZSBmaXJzdCB0aGluZyBpbiBtb3N0IA0K
ZHJpdmVyJ3MgcHJvYmUgZnVuY3Rpb24uIEFzIGEgZmlyc3Qgc3RlcCwgaXQgd291bGQgYmUg
aGVscGZ1bCB0byANCnBvc3Rwb25lIGl0dG8gYSBsYXRlciBwb2ludC4NCg0KPg0KPiBTbyBJ
IGFic29sdXRlbHkgY2xlYXJseSBoYXZlIHRvIHJlamVjdCB0aGUgYW1kZ3B1IHBhdGNoIGlu
IHRoaXMgc2VyaWVzLCB0aGF0IHdpbGwgYnJlYWsgdG9ucyBvZiB1c2UgY2FzZXMuDQoNCkRv
bid0IHdvcnJ5LCB3ZSdyZSBzdGlsbCBpbiB0aGUgZWFybHkgaWRlYXRpb24gcGhhc2UuDQoN
CkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0K
Pg0KPj4+IEkgYWxzbyBkb24ndCB0aGluayBpdCdzIHBvc3NpYmxlIG9yIGV2ZW4gZGVzaXJh
YmxlIGJ5IHNvbWUgZHJpdmVycyB0bw0KPj4+IHJldXNlIHRoZSBpbml0aWFsIHN0YXRlLCBn
b29kIGV4YW1wbGUgaGVyZSBpcyB2bXdnZnggd2hlcmUgYnkgZGVmYXVsdA0KPj4+IHNvbWUg
cGVvcGxlIHdpbGwgc2V0dXAgdGhlaXIgdm0ncyB3aXRoIGUuZy4gOG1iIHJhbSwgd2hlbiB0
aGUgdm13Z2Z4DQo+Pj4gbG9hZHMgd2UgYWxsb3cgc2Nhbm5pbmcgb3V0IGZyb20gc3lzdGVt
IG1lbW9yeSwgc28geW91IGNhbiBzZXQgeW91ciB2bQ0KPj4+IHVwIHdpdGggOG1iIG9mIHZy
YW0gYnV0IHN0aWxsIHVzZSA0ayByZXNvbHV0aW9ucyB3aGVuIHRoZSBkcml2ZXINCj4+PiBs
b2FkcywgdGhpcyB3YXkgdGhlIHN1c3BlbmQgc2l6ZSBvZiB0aGUgdm0gaXMgdmVyeSBwcmVk
aWN0YWJsZSAodGlueQ0KPj4+IHZyYW0gcGx1cyB3aGF0ZXZlciByYW0gd2FzIHNldHVwKSB3
aGlsZSBzdGlsbCBhbGxvd2luZyBhIGxvdCBvZg0KPj4+IGZsZXhpYmlsaXR5Lg0KPj4gSWYg
dGhlcmUncyBubyBpbml0aWFsIHN0YXRlIHRvIHN3aXRjaCBmcm9tLCB0aGUgZmlyc3QgbW9k
ZXNldCBjYW4gZmFpbCB3aGlsZSBsZWF2aW5nIHRoZSBkaXNwbGF5IHVudXNhYmxlLiBUaGVy
ZSdzIG5vIHdheSBhcm91bmQgdGhhdC4gR29pbmcgYmFjayB0byB0aGUgb2xkIHN0YXRlIGlz
IG5vdCBhbiBvcHRpb24gdW5sZXNzIHRoZSBkcml2ZXIgaGFzIGJlZW4gd3JpdHRlbiB0byBz
dXBwb3J0IHRoaXMuDQo+Pg0KPj4gVGhlIGNhc2Ugb2Ygdm13Z2Z4IGlzIHNwZWNpYWwsIGJ1
dCBkb2VzIG5vdCBlZmZlY3QgdGhlIG92ZXJhbGwgcHJvYmxlbS4gRm9yIHZtd2dmeCwgaXQg
d291bGQgYmUgYmVzdCB0byBpbXBvcnQgdGhhdCBpbml0aWFsIHN0YXRlIGFuZCBzdXBwb3J0
IGEgdHJhbnNwYXJlbnQgbW9kZXNldCBmcm9tIHZyYW0gdG8gc3lzdGVtIG1lbW9yeSAoYW5k
IGJhY2spIGF0IGxlYXN0IGR1cmluZyB0aGlzIGluaXRpYWwgc3RhdGUuDQo+Pg0KPj4NCj4+
PiBJbiBnZW5lcmFsIEkgdGhpbmsgaG93ZXZlciB0aGlzIGlzIHBsYW5uZWQgaXQncyB0d28g
b3IgdGhyZWUgc2VwYXJhdGUgc2VyaWVzOg0KPj4+IDEpIGluZnJhc3RydWN0dXJlIHRvIHJl
bG9hZCB0aGUgc3lzZmIgZHJpdmVyICh3aGF0IHRoaXMgc2VyaWVzIGlzKQ0KPj4+IDIpIG1h
a2luZyBzdXJlIHRoYXQgZHJpdmVycyB0aGF0IGRvIHdhbnQgdG8gcmVjb3ZlciBjbGVhbmx5
IGFjdHVhbGx5DQo+Pj4gY2xlYW4gb3V0IGFsbCB0aGUgc3RhdGUgb24gZXhpdCBwcm9wZXJs
eSwNCj4+PiAzKSBhYnN0cmFjdGluZyBhdCBsZWFzdCBzb21lIG9mIHRoYXQgY2xlYW51cCBp
biBzb21lIGRyaXZlciBpbmRlcGVuZGVudCB3YXkNCj4+IFRoYXQncyByZWFsbHkgbm90IGdv
aW5nIHRvIHdvcmsuIEZvciBleGFtcGxlLCBpbiB0aGUgY3VycmVudCBzZXJpZXMsIHlvdSBp
bnZva2UgZGV2bV9hcGVydHVyZV9yZW1vdmVfY29uZmxpY3RpbmdfcGNpX2RldmljZXNfZG9u
ZSgpIGFmdGVyIGRybV9tb2RlX3Jlc2V0KCksIGRybV9kZXZfcmVnaXN0ZXIoKSBhbmQgZHJt
X2NsaWVudF9zZXR1cCgpLiBFYWNoIG9mIHRoZXNlIGNhbGxzIGNhbiBtb2RpZnkgaGFyZHdh
cmUgc3RhdGUuIEluIHRoZSBjYXNlIG9mIF9yZWdpc3RlcigpIGFuZCBfc2V0dXAoKSwgdGhl
IERSTSBjbGllbnRzIGNhbiBwZXJmb3JtIGEgbW9kZXNldCwgd2hpY2ggZGVzdHJveXMgdGhl
IGluaXRpYWwgaGFyZHdhcmUgc3RhdGUuIFBhdGNoIDEgb2YgdGhpcyBzZXJpZXMgcmVtb3Zl
cyB0aGUgc3lzZmIgZGV2aWNlL2RyaXZlciBlbnRpcmVseS4gVGhhdCBzaG91bGQgYmUgYSBu
by1nbyBhcyBpdCBzaWduaWZpY2FudGx5IGNvbXBsaWNhdGVzIHJlY292ZXJ5LiBGb3IgZXhh
bXBsZSwgaWYgdGhlIG5hdGl2ZSBkcml2ZXJzIGZhaWxlZCBmcm9tIGFuIGFsbG9jYXRpb24g
ZmFpbHVyZSwgdGhlIHN5c2ZiIGRldmljZS9kcml2ZXIgaXMgbm90IGxpa2VseSB0byBjb21l
IGJhY2sgZWl0aGVyLiBBcyB0aGUgdmVyeSBmaXJzdCB0aGluZywgdGhlIHNlcmllcyBzaG91
bGQgc3RhdGUgd2hpY2ggZmFpbHVyZXMgaXMgaXMgZ29pbmcgdG8gcmVzb2x2ZSwgLSBmYWls
ZWQgaGFyZHdhcmUgaW5pdCwgLSBpbnZhbGlkIGluaXRpYWwgbW9kZXNldHRpbmcsIC0gcnVu
dGltZSBlcnJvcnMgKHN1Y2ggRU5PTUVNLCBmYWlsZWQgZmlybXdhcmUgbG9hZGluZyksIC0g
b3RoZXJzPyBBbmQgdGhlbiBzcGVjaWZ5IGhvdyBhIHJlY292ZXJ5IHRvIHN5c2ZiIGNvdWxk
IGxvb2sgaW4gZWFjaCBzdXBwb3J0ZWQgc2NlbmFyaW8uIEluIHRlcm1zIG9mIGltcGxlbWVu
dGF0aW9uLCBtYWtlIGFueSB0cmFuc2l0aW9uIGJldHdlZW4gZHJpdmVycw0KPj4gZ3JhZHVh
bGx5LiBUaGUgbmF0aXZlIGRyaXZlciBuZWVkcyB0byBhY3F1aXJlIHRoZSBoYXJkd2FyZSBy
ZXNvdXJjZSAoZnJhbWVidWZmZXIgYW5kIEkvTyBhcGVydHVyZXMpIHdpdGhvdXQgdW5sb2Fk
aW5nIHRoZSBzeXNmYiBkcml2ZXIuIEx1Y2tpbHkgdGhlcmUncyBzdHJ1Y3QgZHJtX2Rldmlj
ZS51bnBsdWcsIHdoaWNoIGRvZXMgdGhhdC4gWzFdIEZsaXBwaW5nIHRoaXMgZmllbGQgZGlz
YWJsZXMgaGFyZHdhcmUgYWNjZXNzIGZvciBEUk0gZHJpdmVycy4gQWxsIHN5c2ZiIGRyaXZl
cnMgc3VwcG9ydCB0aGlzLiBUbyBnZXQgdGhlIHN5c2ZiIGRyaXZlcnMgcmVhZHksIEkgc3Vn
Z2VzdCBkZWRpY2F0ZWQgaGVscGVycyBmb3IgZWFjaCBkcml2ZXJzIGFwZXJ0dXJlLiBUaGUg
YXBlcnR1cmUgaGVscGVycyBjYW4gdXNlIHRoZXNlIGNhbGxiYWNrIHRvIGZsaXAgdGhlIERS
TSBkcml2ZXIgb2ZmIGFuZCBvbiBhZ2Fpbi4gRm9yIGV4YW1wbGUsIGVmaWRybSBjb3VsZCBk
byB0aGlzIGFzIGEgbWluaW11bTogaW50IGVmaWRybV9hcGVydHVyZV9zdXNwZW5kKCkgeyBk
ZXYtPnVucGx1ZyA9IHRydWU7IHJlbW92ZV9yZXNvdXJjZSgvKmZyYW1lYnVmZmVyIGFwZXJ0
dXJlKi8pIHJldHVybiAwIH0gaW50IGVmaWRybV9hcGVydHVyZV9yZXN1bWUoKSB7IGluc2Vy
dF9yZXNvdXJjZSgvKmZyYW1lYnVmZmVyIGFwZXJ0dXJlKi8pIGRldi0+dW5wbHVnID0gZmFs
c2U7IHJldHVybiAwIH0gc3RydWN0IGFwZXJ0dXJlX2Z1bmNzIGVmaWRybV9hcGVydHVyZV9m
dW5jcyB7IC5zdXNwZW5kID0gZWZpZHJtX2FwZXJ0dXJlX3N1c3BlbmQsIC5yZXN1bWUgPSBl
Zmlkcm1fYXBlcnR1cmVfcmVzdW1lLCB9IFBhc3MgdGhpcyBzdHJ1Y3Qgd2hlbiBlZmlkcm0g
YWNxdWlyZXMgdGhlIGZyYW1lYnVmZmVyIGFwZXJ0dXJlLCBzbyB0aGF0IHRoZSBhcGVydHVy
ZSBoZWxwZXJzIGNhbiBjb250cm9sIHRoZSBiZWhhdmlvciBvZiBlZmlkcm0uIFdpdGggdGhp
cywgYSBtdWx0aS0NCj4+IHN0ZXAgdGFrZW92ZXIgZnJvbSBzeXNmYiB0byBuYXRpdmUgZHJp
dmVyIGNhbiBiZSB0cmllZC4gSXQncyBzdGlsbCBhIG1hc3NpdmUgZWZmb3J0IHRoYXQgcmVx
dWlyZXMgYW4gYXVkaXQgb2YgZWFjaCBkcml2ZXIncyBwcm9iaW5nIGxvZ2ljLiBUaGVyZSdz
IG5vIGNvcHktcGFzdGUgcGF0dGVybiBBRkFJQ1QuIEkgc3VnZ2VzdCB0byBwaWNrIG9uZSBz
aW1wbGUgZHJpdmVyIGZpcnN0IGFuZCBtYWtlIGEgcHJvdG90eXBlLiBMZXQgbWUgYWxzbyBz
YXkgdGhhdCBJIERPIGxpa2UgdGhlIGdlbmVyYWwgaWRlYSB5b3UncmUgcHJvcG9zaW5nLiBC
dXQgaWYgaXQgd2FzIGVhc3ksIHdlIHdvdWxkIGxpa2VseSBoYXZlIGRvbmUgaXQgYWxyZWFk
eS4gQmVzdCByZWdhcmRzIFRob21hcw0KPj4+IHoNCg0KLS0gDQotLQ0KVGhvbWFzIFppbW1l
cm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0ci4gMTQ2LCA5MDQ2MSBOw7xybmJlcmcsIEdl
cm1hbnksIHd3dy5zdXNlLmNvbQ0KR0Y6IEpvY2hlbiBKYXNlciwgQW5kcmV3IE1jRG9uYWxk
LCBXZXJuZXIgS25vYmxpY2gsIChIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCg0KDQo=

