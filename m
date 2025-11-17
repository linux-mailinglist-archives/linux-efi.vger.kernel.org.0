Return-Path: <linux-efi+bounces-5528-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181DC62D5E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 09:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534933A22B9
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74A30C622;
	Mon, 17 Nov 2025 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nWQ8PkcS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PJOi6w9N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PI9ahSwo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="frYCigBw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A723EA89
	for <linux-efi@vger.kernel.org>; Mon, 17 Nov 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366521; cv=none; b=XzfT0XxhuG4xb2QTaHDbYqCkh90GXIlb48HLrTaxlFraZVdatPo0hBTk0EpT08tDr4WkTUOKaRaFMQ4y9jjukYdRQcexpiruFaEOghaw0h2nIs5I0DEEPA3XQgiX9VK2wDPfp/vyPtegMXiB1Sp2gAYDjfj7kmFyoUZEJq2HCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366521; c=relaxed/simple;
	bh=aY311A0/yYStn8uFHQpeJMSm+MiGO1KHhqXRJhIlFkE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=dT+2nQyAs811mv3o118f0RT7ly8EH8wVEApca/wLTd73qsz8NJBZPO9eaTBphOzsTuVfFNW2BoAnmC6p00PkzNpiaHOAlSEsUYlVWfJ06w5GVceIdZmKredWQaJ2NgIysrGI0aaQSNvaaXO5NKk0OEiZvNdymoM6cbLXgCk+xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nWQ8PkcS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PJOi6w9N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PI9ahSwo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=frYCigBw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFFE3211FF;
	Mon, 17 Nov 2025 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763366517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0/4CkK3GCV1R4AErX7rzcm0Es2PQ539kFTbGmG1CLU=;
	b=nWQ8PkcSeZVkJE8IuHhnyK4A6jrlIu3ekG5uuKmQJoFxhFRobkNKd6WWCV8AWfMJbn8h3W
	fKh/ug8soG1yWfGHpaZJOJ6lsXcF588EuffbeLTbukhJUCXQE+rjaqXSQdrinRN2BjmzHX
	A38vvbVO+16lyoXbMZlgmpSbuCBfHaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763366517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0/4CkK3GCV1R4AErX7rzcm0Es2PQ539kFTbGmG1CLU=;
	b=PJOi6w9NVzu3S0Cs/nlEj8hCBNrPSYGy3NIXLbZS2HmqyYu3r+rA5ezUvgyBTNC/h18oYu
	BVvpRe4Ks8MuPjBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PI9ahSwo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=frYCigBw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763366516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0/4CkK3GCV1R4AErX7rzcm0Es2PQ539kFTbGmG1CLU=;
	b=PI9ahSwojq/F+qkUfs55eRScnHcw06Y8na6otV5N2McfHrY0oxkKCOpVkT5YV20ymL1hPM
	5fttXs9jUp8lVMkjUd+UzRtqUgG5R5BoAZWLrofQ5a9B18TbeQT4YxuAJNnNG1Ii9lzEaO
	0y+ALaNW4BqU9q32AaJWpJy56FVql58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763366516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0/4CkK3GCV1R4AErX7rzcm0Es2PQ539kFTbGmG1CLU=;
	b=frYCigBwqDRa3EPZGdlCIxg5wSQmqaravkg/bIIWtv4At91eOdlGczJsB8SxBvof9vXEx5
	QgJsx/5jkG/gHNCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B69683EA61;
	Mon, 17 Nov 2025 08:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ivrhKnTWGmnCPQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Nov 2025 08:01:56 +0000
Content-Type: multipart/mixed; boundary="------------r0Xzb0YoVLDjAiumVA0VLV75"
Message-ID: <b6801420-6ae4-44cb-9d86-e9353a2a59d8@suse.de>
Date: Mon, 17 Nov 2025 09:01:56 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] efi: x86: Provide EDID from GOP device
To: Ard Biesheuvel <ardb@kernel.org>
Cc: jonathan@marek.ca, javierm@redhat.com, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <CAMj1kXF62pEMUJAM12HnF7qMt5xhZaZXpPoMdebMUKCfoAYisQ@mail.gmail.com>
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
In-Reply-To: <CAMj1kXF62pEMUJAM12HnF7qMt5xhZaZXpPoMdebMUKCfoAYisQ@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EFFE3211FF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.41 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.41

This is a multi-part message in MIME format.
--------------r0Xzb0YoVLDjAiumVA0VLV75
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 14.11.25 um 09:31 schrieb Ard Biesheuvel:
> On Wed, 15 Oct 2025 at 18:08, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Add support for EFI_EDID_ACTIVE_PROTOCOL and EFI_EDID_DISCOVERED_PROTOCOL
>> on x86. Refactor the GOP helpers for EDID support, then retrieve the EDID
>> into x86 boot_params.
>>
>> Later boot code copies the EDID from the boot parameters into the global
>> variable edid_info. Graphics drivers, such as efidrm, can pick up the
>> information from there. In the case of efidrm, it provides the EDID to
>> user-space compositors, which use it for improved QoS on the display
>> output. Similar functionality is already available on old VESA systems
>> with vesadrm.
>>
>> Tested on x86 EFI systems.
>>
>> Another patch is required to provide EDID on non-x86 systems via the
>> generic EFI stub. The implementation can directly build upon this
>> series.
>>
>> Thomas Zimmermann (5):
>>    efi: Fix trailing whitespace in header file
>>    efi/libstub: gop: Find GOP handle instead of GOP data
>>    efi/libstub: gop: Initialize screen_info in helper function
>>    efi/libstub: gop: Add support for reading EDID
>>    efi/libstub: x86: Store EDID in boot_params
>>
> Hi,
>
> Apologies for the delay. This series looks fine to me, although I
> would prefer it if we could make things a bit more generic?
>
> Everything you are adding here is arch-agnostic, except for the bit
> where we use x86-specific plumbing to pass the EDID info between the
> EFI stub and the core kernel.

Attached is an RFC patch that I already have. This would be the next 
step for EDID support. I've not yet sent the generic-EFI patch, as I did 
not have opportunity to test it. The patch addresses most of what you 
ask for, I think.

>
> More specifically, could we do the following:
> - move struct edid_info edid_info into common code

edid_info is related to screen_info, so it follows the same conventions. 
Arnd Bergmann made x86-specific changes for screen_info in commit 
b8466fe82b79 ("efi: move screen_info into efi init code"). x86 has it's 
own thing, sort of. See the attached patch for my non-x86 solution.

> - pass the detected EDID info block via a EFI config table instead of
> boot_params

The x86 code uses boot params for screen_info already and also transfers 
edid_info on VESA systems via boot params (or if grub set up boot_params 
for us). [1] It's all there and working already. If we transfer 
edid_info via config table, we'd need extra code on x86.

> - make CONFIG_FIRMWARE_EDID depend on (X86 || EFI_STUB)

See the attached patch.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


--------------r0Xzb0YoVLDjAiumVA0VLV75
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-efi-transfer-EDID-from-stub-to-kernel.patch"
Content-Disposition: attachment;
 filename="0001-efi-transfer-EDID-from-stub-to-kernel.patch"
Content-Transfer-Encoding: base64

RnJvbSAxMGJlOTE3YjBjZjkwZjIyZjJmZDkwMDYyMGNiOWFjZjU4MzhmZjU1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogV2VkLCAxNSBPY3QgMjAyNSAxMzozNjowNiArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGVmaTogdHJhbnNmZXIgRURJRCBmcm9tIHN0dWIgdG8ga2VybmVsCgotIEFk
ZCBVVUlEIGZvciBzdG9yaW5nIHRoZSBFRElEIGRhdGEgaW4gdGhlIFVFRkkgY29uZmlndXJh
dGlvbiB0YWJsZS4KLSBUaGUgVVVJRCBoYXMgYmVlbiBjcmVhdGVkIGJ5IHV1aWRnZW4uCi0g
RW5hYmxlIGVkaWRfaW5mbyBvbiBFRkkgc3lzdGVtcwotLS0KIGRyaXZlcnMvZmlybXdhcmUv
ZWZpL2VmaS1pbml0LmMgICAgICAgICAgICAgICB8IDMzICsrKysrKysrKysrKystCiBkcml2
ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYyAgICAgICAgICAgICAgICAgICAgfCAgMiArCiBkcml2
ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlICAgICAgICAgfCAgMiArLQogZHJp
dmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZGlkX2luZm8uYyAgICAgIHwgNDAgKysrKysr
KysrKysrKysrKysKIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItZW50
cnkuYyB8IDE3ICsrKysrKysKIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0
dWIuYyAgICAgICB8IDQ0ICsrKysrKysrKysrKystLS0tLS0KIGRyaXZlcnMvZmlybXdhcmUv
ZWZpL2xpYnN0dWIvZWZpc3R1Yi5oICAgICAgICB8ICA0ICsrCiBkcml2ZXJzL3ZpZGVvL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKy0tCiBpbmNsdWRlL2xpbnV4
L2VmaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKy0tCiA5IGZpbGVzIGNo
YW5nZWQsIDEzNiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VkaWRfaW5mby5jCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLWluaXQuYyBiL2RyaXZlcnMvZmly
bXdhcmUvZWZpL2VmaS1pbml0LmMKaW5kZXggYTY1YzJkNWI5ZTdiLi4yNzE5MzExZjJkNDMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS1pbml0LmMKKysrIGIvZHJp
dmVycy9maXJtd2FyZS9lZmkvZWZpLWluaXQuYwpAQCAtMjMsNyArMjMsMTAgQEAKIAogI2lu
Y2x1ZGUgPGFzbS9lZmkuaD4KIAorI2luY2x1ZGUgPHZpZGVvL2VkaWQuaD4KKwogdW5zaWdu
ZWQgbG9uZyBfX2luaXRkYXRhIHNjcmVlbl9pbmZvX3RhYmxlID0gRUZJX0lOVkFMSURfVEFC
TEVfQUREUjsKK3Vuc2lnbmVkIGxvbmcgX19pbml0ZGF0YSBlZGlkX2luZm9fdGFibGUgPSBF
RklfSU5WQUxJRF9UQUJMRV9BRERSOwogCiBzdGF0aWMgaW50IF9faW5pdCBpc19tZW1vcnko
ZWZpX21lbW9yeV9kZXNjX3QgKm1kKQogewpAQCAtNTcsMTQgKzYwLDE5IEBAIHN0YXRpYyBw
aHlzX2FkZHJfdCBfX2luaXQgZWZpX3RvX3BoeXModW5zaWduZWQgbG9uZyBhZGRyKQogZXh0
ZXJuIF9fd2VhayBjb25zdCBlZmlfY29uZmlnX3RhYmxlX3R5cGVfdCBlZmlfYXJjaF90YWJs
ZXNbXTsKIAogLyoKLSAqIHg4NiBkZWZpbmVzIGl0cyBvd24gc2NyZWVuX2luZm8gYW5kIHVz
ZXMgaXQgZXZlbiB3aXRob3V0IEVGSSwKLSAqIGV2ZXJ5dGhpbmcgZWxzZSBjYW4gZ2V0IGl0
IGZyb20gaGVyZS4KKyAqIHg4NiBkZWZpbmVzIGl0cyBvd24gc2NyZWVuX2luZm8gYW5kIGVk
aWRfaW5mbyBhbmQgdXNlcyB0aGVtIGV2ZW4KKyAqIHdpdGhvdXQgRUZJLCBldmVyeXRoaW5n
IGVsc2UgY2FuIGdldCB0aGVtIGZyb20gaGVyZS4KICAqLwogI2lmICFkZWZpbmVkKENPTkZJ
R19YODYpICYmIChkZWZpbmVkKENPTkZJR19TWVNGQikgfHwgZGVmaW5lZChDT05GSUdfRUZJ
X0VBUkxZQ09OKSkKIHN0cnVjdCBzY3JlZW5faW5mbyBzY3JlZW5faW5mbyBfX3NlY3Rpb24o
Ii5kYXRhIik7CiBFWFBPUlRfU1lNQk9MX0dQTChzY3JlZW5faW5mbyk7CiAjZW5kaWYKIAor
I2lmICFkZWZpbmVkKENPTkZJR19YODYpICYmIGRlZmluZWQoQ09ORklHX0ZJUk1XQVJFX0VE
SUQpCitzdHJ1Y3QgZWRpZF9pbmZvIGVkaWRfaW5mbyBfX3NlY3Rpb24oIi5kYXRhIik7CitF
WFBPUlRfU1lNQk9MX0dQTChlZGlkX2luZm8pOworI2VuZGlmCisKIHN0YXRpYyB2b2lkIF9f
aW5pdCBpbml0X3NjcmVlbl9pbmZvKHZvaWQpCiB7CiAJc3RydWN0IHNjcmVlbl9pbmZvICpz
aTsKQEAgLTg4LDYgKzk2LDIzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbml0X3NjcmVlbl9p
bmZvKHZvaWQpCiAJfQogfQogCitzdGF0aWMgdm9pZCBfX2luaXQgaW5pdF9lZGlkX2luZm8o
dm9pZCkKK3sKKyNpZiBkZWZpbmVkKENPTkZJR19GSVJNV0FSRV9FRElEKQorCXN0cnVjdCBl
ZGlkX2luZm8gKmVkaWQ7CisKKwlpZiAoZWRpZF9pbmZvX3RhYmxlID09IEVGSV9JTlZBTElE
X1RBQkxFX0FERFIpCisJCXJldHVybjsKKworCWVkaWQgPSBlYXJseV9tZW1yZW1hcChlZGlk
X2luZm9fdGFibGUsIHNpemVvZigqZWRpZCkpOworCWlmICghZWRpZCkKKwkJcmV0dXJuOyAv
KiBub3QgYW4gZXJyb3I7IEVESUQgaXMgb3B0aW9uYWwgKi8KKwllZGlkX2luZm8gPSAqZWRp
ZDsKKwltZW1zZXQoZWRpZCwgMCwgc2l6ZW9mKCplZGlkKSk7CisJZWFybHlfbWVtdW5tYXAo
ZWRpZCwgc2l6ZW9mKCplZGlkKSk7CisjZW5kaWYKK30KKwogc3RhdGljIGludCBfX2luaXQg
dWVmaV9pbml0KHU2NCBlZmlfc3lzdGVtX3RhYmxlKQogewogCWVmaV9jb25maWdfdGFibGVf
dCAqY29uZmlnX3RhYmxlczsKQEAgLTI3NSw0ICszMDAsOCBAQCB2b2lkIF9faW5pdCBlZmlf
aW5pdCh2b2lkKQogCSAgICBJU19FTkFCTEVEKENPTkZJR19TWVNGQikgfHwKIAkgICAgSVNf
RU5BQkxFRChDT05GSUdfRUZJX0VBUkxZQ09OKSkKIAkJaW5pdF9zY3JlZW5faW5mbygpOwor
CisJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4NikgfHwKKwkgICAgSVNfRU5BQkxFRChDT05G
SUdfRklSTVdBUkVfRURJRCkpCisJCWluaXRfZWRpZF9pbmZvKCk7CiB9CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2Vm
aS5jCmluZGV4IDFjZTQyOGUyYWM4YS4uN2EzMDQ3YTIzOGFlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYworKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmku
YwpAQCAtNjQsNiArNjQsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBfX2luaXRkYXRhIHJ0
X3Byb3AgPSBFRklfSU5WQUxJRF9UQUJMRV9BRERSOwogc3RhdGljIHVuc2lnbmVkIGxvbmcg
X19pbml0ZGF0YSBpbml0cmQgPSBFRklfSU5WQUxJRF9UQUJMRV9BRERSOwogCiBleHRlcm4g
dW5zaWduZWQgbG9uZyBzY3JlZW5faW5mb190YWJsZTsKK2V4dGVybiB1bnNpZ25lZCBsb25n
IGVkaWRfaW5mb190YWJsZTsKIAogc3RydWN0IG1tX3N0cnVjdCBlZmlfbW0gPSB7CiAJLm1t
X210CQkJPSBNVFJFRV9JTklUX0VYVChtbV9tdCwgTU1fTVRfRkxBR1MsIGVmaV9tbS5tbWFw
X2xvY2spLApAQCAtNjM5LDYgKzY0MCw3IEBAIHN0YXRpYyBjb25zdCBlZmlfY29uZmlnX3Rh
YmxlX3R5cGVfdCBjb21tb25fdGFibGVzW10gX19pbml0Y29uc3QgPSB7CiAjZW5kaWYKICNp
ZmRlZiBDT05GSUdfRUZJX0dFTkVSSUNfU1RVQgogCXtMSU5VWF9FRklfU0NSRUVOX0lORk9f
VEFCTEVfR1VJRCwJJnNjcmVlbl9pbmZvX3RhYmxlCQkJfSwKKwl7TElOVVhfRUZJX0VESURf
SU5GT19UQUJMRV9HVUlELAkmZWRpZF9pbmZvX3RhYmxlCQkJfSwKICNlbmRpZgogCXt9LAog
fTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUg
Yi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlCmluZGV4IDk0YjA1ZTQ0
NTFkZC4uMTJhZTVjNmJlMDI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9s
aWJzdHViL01ha2VmaWxlCisrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFr
ZWZpbGUKQEAgLTgwLDcgKzgwLDcgQEAgJChvYmopL2xpYi0lLm86ICQoc3JjdHJlZSkvbGli
LyUuYyBGT1JDRQogCSQoY2FsbCBpZl9jaGFuZ2VkX3J1bGUsY2Nfb19jKQogCiBsaWItJChD
T05GSUdfRUZJX0dFTkVSSUNfU1RVQikJKz0gZWZpLXN0dWIubyBzdHJpbmcubyBpbnRyaW5z
aWNzLm8gc3lzdGFibGUubyBcCi0JCQkJICAgc2NyZWVuX2luZm8ubyBlZmktc3R1Yi1lbnRy
eS5vCisJCQkJICAgc2NyZWVuX2luZm8ubyBlZGlkX2luZm8ubyBlZmktc3R1Yi1lbnRyeS5v
CiAKIGxpYi0kKENPTkZJR19BUk0pCQkrPSBhcm0zMi1zdHViLm8KIGxpYi0kKENPTkZJR19B
Uk02NCkJCSs9IGthc2xyLm8gYXJtNjQubyBhcm02NC1zdHViLm8gc21iaW9zLm8KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWRpZF9pbmZvLmMgYi9kcml2
ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VkaWRfaW5mby5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uODgyYzg1ZmFmMzk1Ci0tLSAvZGV2L251bGwKKysr
IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZGlkX2luZm8uYwpAQCAtMCwwICsx
LDQwIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAorCisjaW5jbHVk
ZSA8bGludXgvZWZpLmg+CisjaW5jbHVkZSA8dmlkZW8vZWRpZC5oPgorI2luY2x1ZGUgPGFz
bS9lZmkuaD4KKworI2luY2x1ZGUgImVmaXN0dWIuaCIKKworc3RhdGljIGVmaV9ndWlkX3Qg
ZWRpZF9pbmZvX2d1aWQgPSBMSU5VWF9FRklfRURJRF9JTkZPX1RBQkxFX0dVSUQ7CisKK3N0
cnVjdCBlZGlkX2luZm8gKl9fYWxsb2NfZWRpZF9pbmZvKHZvaWQpCit7CisJc3RydWN0IGVk
aWRfaW5mbyAqZWRpZDsKKwllZmlfc3RhdHVzX3Qgc3RhdHVzOworCisJc3RhdHVzID0gZWZp
X2JzX2NhbGwoYWxsb2NhdGVfcG9vbCwgRUZJX0FDUElfUkVDTEFJTV9NRU1PUlksCisJCQkg
ICAgIHNpemVvZigqZWRpZCksICh2b2lkICoqKSZlZGlkKTsKKworCWlmIChzdGF0dXMgIT0g
RUZJX1NVQ0NFU1MpCisJCXJldHVybiBOVUxMOworCisJbWVtc2V0KGVkaWQsIDAsIHNpemVv
ZigqZWRpZCkpOworCisJc3RhdHVzID0gZWZpX2JzX2NhbGwoaW5zdGFsbF9jb25maWd1cmF0
aW9uX3RhYmxlLAorCQkJICAgICAmZWRpZF9pbmZvX2d1aWQsIGVkaWQpOworCWlmIChzdGF0
dXMgPT0gRUZJX1NVQ0NFU1MpCisJCXJldHVybiBlZGlkOworCisJZWZpX2JzX2NhbGwoZnJl
ZV9wb29sLCBlZGlkKTsKKwlyZXR1cm4gTlVMTDsKK30KKwordm9pZCBmcmVlX2VkaWRfaW5m
byhzdHJ1Y3QgZWRpZF9pbmZvICplZGlkKQoreworCWlmICghZWRpZCkKKwkJcmV0dXJuOwor
CisJZWZpX2JzX2NhbGwoaW5zdGFsbF9jb25maWd1cmF0aW9uX3RhYmxlLCAmZWRpZF9pbmZv
X2d1aWQsIE5VTEwpOworCWVmaV9ic19jYWxsKGZyZWVfcG9vbCwgZWRpZCk7Cit9CmRpZmYg
LS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLWVudHJ5LmMg
Yi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLWVudHJ5LmMKaW5kZXgg
YTZjMDQ5ODM1MTkwLi43YmE4YTIzYmJjNTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItZW50cnkuYworKysgYi9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9saWJzdHViL2VmaS1zdHViLWVudHJ5LmMKQEAgLTUsOSArNSwxMiBAQAogCiAjaW5j
bHVkZSA8YXNtL2VmaS5oPgogCisjaW5jbHVkZSA8dmlkZW8vZWRpZC5oPgorCiAjaW5jbHVk
ZSAiZWZpc3R1Yi5oIgogCiBzdGF0aWMgdW5zaWduZWQgbG9uZyBzY3JlZW5faW5mb19vZmZz
ZXQ7CitzdGF0aWMgdW5zaWduZWQgbG9uZyBlZGlkX2luZm9fb2Zmc2V0OwogCiBzdHJ1Y3Qg
c2NyZWVuX2luZm8gKmFsbG9jX3NjcmVlbl9pbmZvKHZvaWQpCiB7CkBAIC0yMiw2ICsyNSwx
OSBAQCBzdHJ1Y3Qgc2NyZWVuX2luZm8gKmFsbG9jX3NjcmVlbl9pbmZvKHZvaWQpCiAJcmV0
dXJuIE5VTEw7CiB9CiAKK3N0cnVjdCBlZGlkX2luZm8gKmFsbG9jX2VkaWRfaW5mbyh2b2lk
KQoreworI2lmIGRlZmluZWQoQ09ORklHX0ZJUk1XQVJFX0VESUQpCisJaWYgKElTX0VOQUJM
RUQoQ09ORklHX0FSTSkpCisJCXJldHVybiBfX2FsbG9jX2VkaWRfaW5mbygpOworCisJaWYg
KElTX0VOQUJMRUQoQ09ORklHX1g4NikgJiYKKwkgICAgSVNfRU5BQkxFRChDT05GSUdfRklS
TVdBUkVfRURJRCkpCisJCXJldHVybiAodm9pZCAqKSZlZGlkX2luZm8gKyBlZGlkX2luZm9f
b2Zmc2V0OworI2VuZGlmCisJcmV0dXJuIE5VTEw7Cit9CisKIC8qCiAgKiBFRkkgZW50cnkg
cG9pbnQgZm9yIHRoZSBnZW5lcmljIEVGSSBzdHViIHVzZWQgYnkgQVJNLCBhcm02NCwgUklT
Qy1WIGFuZAogICogTG9vbmdBcmNoLiBUaGlzIGlzIHRoZSBlbnRyeXBvaW50IHRoYXQgaXMg
ZGVzY3JpYmVkIGluIHRoZSBQRS9DT0ZGIGhlYWRlcgpAQCAtNzQsNiArOTAsNyBAQCBlZmlf
c3RhdHVzX3QgX19lZmlhcGkgZWZpX3BlX2VudHJ5KGVmaV9oYW5kbGVfdCBoYW5kbGUsCiAJ
fQogCiAJc2NyZWVuX2luZm9fb2Zmc2V0ID0gaW1hZ2VfYWRkciAtICh1bnNpZ25lZCBsb25n
KWltYWdlLT5pbWFnZV9iYXNlOworCWVkaWRfaW5mb19vZmZzZXQgPSBpbWFnZV9hZGRyIC0g
KHVuc2lnbmVkIGxvbmcpaW1hZ2UtPmltYWdlX2Jhc2U7CiAKIAlzdGF0dXMgPSBlZmlfc3R1
Yl9jb21tb24oaGFuZGxlLCBpbWFnZSwgaW1hZ2VfYWRkciwgY21kbGluZV9wdHIpOwogCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLmMgYi9k
cml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLmMKaW5kZXggOWNiODE0YzVi
YTFiLi45Y2IyYTVjMTU0YjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvZWZpLXN0dWIuYworKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2Vm
aS1zdHViLmMKQEAgLTEyLDYgKzEyLDcgQEAKICNpbmNsdWRlIDxsaW51eC9lZmkuaD4KICNp
bmNsdWRlIDxsaW51eC9zY3JlZW5faW5mby5oPgogI2luY2x1ZGUgPGFzbS9lZmkuaD4KKyNp
bmNsdWRlIDx2aWRlby9lZGlkLmg+CiAKICNpbmNsdWRlICJlZmlzdHViLmgiCiAKQEAgLTQ5
LDIyICs1MCwzNyBAQCBzdGF0aWMgdTY0IHZpcnRtYXBfYmFzZSA9IEVGSV9SVF9WSVJUVUFM
X0JBU0U7CiBzdGF0aWMgYm9vbCBmbGF0X3ZhX21hcHBpbmcgPSAoRUZJX1JUX1ZJUlRVQUxf
T0ZGU0VUICE9IDApOwogCiB2b2lkIF9fd2VhayBmcmVlX3NjcmVlbl9pbmZvKHN0cnVjdCBz
Y3JlZW5faW5mbyAqc2kpCi17Ci19Cit7IH0KKwordm9pZCBfX3dlYWsgZnJlZV9lZGlkX2lu
Zm8oc3RydWN0IGVkaWRfaW5mbyAqZWRpZCkKK3sgfQogCi1zdGF0aWMgc3RydWN0IHNjcmVl
bl9pbmZvICpzZXR1cF9ncmFwaGljcyh2b2lkKQorc3RhdGljIHZvaWQgc2V0dXBfZ3JhcGhp
Y3Moc3RydWN0IHNjcmVlbl9pbmZvICoqc2ksIHN0cnVjdCBlZGlkX2luZm8gKiplZGlkKQog
ewotCXN0cnVjdCBzY3JlZW5faW5mbyAqc2ksIHRtcCA9IHt9OworCWVmaV9zdGF0dXNfdCBz
dGF0dXM7CisKKwkqc2kgPSBhbGxvY19zY3JlZW5faW5mbygpOworCSplZGlkID0gYWxsb2Nf
ZWRpZF9pbmZvKCk7CiAKLQlpZiAoZWZpX3NldHVwX2dyYXBoaWNzKCZ0bXAsIE5VTEwpICE9
IEVGSV9TVUNDRVNTKQotCQlyZXR1cm4gTlVMTDsKKwlpZiAoISpzaSAmJiAhKmVkaWQpCisJ
CXJldHVybjsKIAotCXNpID0gYWxsb2Nfc2NyZWVuX2luZm8oKTsKLQlpZiAoIXNpKQotCQly
ZXR1cm4gTlVMTDsKKwlzdGF0dXMgPSBlZmlfc2V0dXBfZ3JhcGhpY3MoKnNpLCAqZWRpZCk7
CisJaWYgKHN0YXR1cykgeworCQkvKiBDbGVhciBvbiBlcnJvciAqLworCQlpZiAoKmVkaWQp
CisJCQltZW1zZXQoKmVkaWQsIDAsIHNpemVvZigqKmVkaWQpKTsKKwkJaWYgKCpzaSkKKwkJ
CW1lbXNldCgqc2ksIDAsIHNpemVvZigqKnNpKSk7CisJfQorfQogCi0JKnNpID0gdG1wOwot
CXJldHVybiBzaTsKK3N0YXRpYyB2b2lkIHJlbGVhc2VfZ3JhcGhpY3Moc3RydWN0IHNjcmVl
bl9pbmZvICpzaSwgc3RydWN0IGVkaWRfaW5mbyAqZWRpZCkKK3sKKwlpZiAoZWRpZCkKKwkJ
ZnJlZV9lZGlkX2luZm8oZWRpZCk7CisJaWYgKHNpKQorCQlmcmVlX3NjcmVlbl9pbmZvKHNp
KTsKIH0KIAogc3RhdGljIHZvaWQgaW5zdGFsbF9tZW1yZXNlcnZlX3RhYmxlKHZvaWQpCkBA
IC0xNDYsMTMgKzE2MiwxNCBAQCBlZmlfc3RhdHVzX3QgZWZpX3N0dWJfY29tbW9uKGVmaV9o
YW5kbGVfdCBoYW5kbGUsCiAJCQkgICAgIGNoYXIgKmNtZGxpbmVfcHRyKQogewogCXN0cnVj
dCBzY3JlZW5faW5mbyAqc2k7CisJc3RydWN0IGVkaWRfaW5mbyAqZWRpZDsKIAllZmlfc3Rh
dHVzX3Qgc3RhdHVzOwogCiAJc3RhdHVzID0gY2hlY2tfcGxhdGZvcm1fZmVhdHVyZXMoKTsK
IAlpZiAoc3RhdHVzICE9IEVGSV9TVUNDRVNTKQogCQlyZXR1cm4gc3RhdHVzOwogCi0Jc2kg
PSBzZXR1cF9ncmFwaGljcygpOworCXNldHVwX2dyYXBoaWNzKCZzaSwgJmVkaWQpOwogCiAJ
ZWZpX3JldHJpZXZlX2V2ZW50bG9nKCk7CiAKQEAgLTE3Miw3ICsxODksOCBAQCBlZmlfc3Rh
dHVzX3QgZWZpX3N0dWJfY29tbW9uKGVmaV9oYW5kbGVfdCBoYW5kbGUsCiAKIAlzdGF0dXMg
PSBlZmlfYm9vdF9rZXJuZWwoaGFuZGxlLCBpbWFnZSwgaW1hZ2VfYWRkciwgY21kbGluZV9w
dHIpOwogCi0JZnJlZV9zY3JlZW5faW5mbyhzaSk7CisJcmVsZWFzZV9ncmFwaGljcyhzaSwg
ZWRpZCk7CisKIAlyZXR1cm4gc3RhdHVzOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Zp
cm13YXJlL2VmaS9saWJzdHViL2VmaXN0dWIuaCBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvZWZpc3R1Yi5oCmluZGV4IGIyZmIwYzNmYTcyMS4uMTIwYzlhNDk5MzYyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaXN0dWIuaAorKysgYi9k
cml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaXN0dWIuaApAQCAtMTE3OSw2ICsxMTc5
LDEwIEBAIHN0cnVjdCBzY3JlZW5faW5mbyAqYWxsb2Nfc2NyZWVuX2luZm8odm9pZCk7CiBz
dHJ1Y3Qgc2NyZWVuX2luZm8gKl9fYWxsb2Nfc2NyZWVuX2luZm8odm9pZCk7CiB2b2lkIGZy
ZWVfc2NyZWVuX2luZm8oc3RydWN0IHNjcmVlbl9pbmZvICpzaSk7CiAKK3N0cnVjdCBlZGlk
X2luZm8gKmFsbG9jX2VkaWRfaW5mbyh2b2lkKTsKK3N0cnVjdCBlZGlkX2luZm8gKl9fYWxs
b2NfZWRpZF9pbmZvKHZvaWQpOwordm9pZCBmcmVlX2VkaWRfaW5mbyhzdHJ1Y3QgZWRpZF9p
bmZvICplZGlkKTsKKwogdm9pZCBlZmlfY2FjaGVfc3luY19pbWFnZSh1bnNpZ25lZCBsb25n
IGltYWdlX2Jhc2UsCiAJCQkgIHVuc2lnbmVkIGxvbmcgYWxsb2Nfc2l6ZSk7CiAKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlkZW8vS2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vS2NvbmZpZwpp
bmRleCBkNTE3NzdkZjEyZDEuLmY0NTJmYWM5MGE5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aWRlby9LY29uZmlnCisrKyBiL2RyaXZlcnMvdmlkZW8vS2NvbmZpZwpAQCAtNjMsMTEgKzYz
LDEzIEBAIGVuZGlmICMgSEFTX0lPTUVNCiAKIGNvbmZpZyBGSVJNV0FSRV9FRElECiAJYm9v
bCAiRW5hYmxlIGZpcm13YXJlIEVESUQiCi0JZGVwZW5kcyBvbiBYODYKKwlkZXBlbmRzIG9u
IEVGSSB8fCBYODYKIAloZWxwCiAJICBUaGlzIGVuYWJsZXMgYWNjZXNzIHRvIHRoZSBFRElE
IHRyYW5zZmVycmVkIGZyb20gdGhlIGZpcm13YXJlLgotCSAgT24geDg2LCB0aGlzIGlzIGZy
b20gdGhlIFZFU0EgQklPUy4gRFJNIGRpc3BsYXkgZHJpdmVycyB3aWxsCi0JICBiZSBhYmxl
IHRvIGV4cG9ydCB0aGUgaW5mb3JtYXRpb24gdG8gdXNlcnNwYWNlLgorCSAgT24gRUZJIHN5
c3RlbXMsIHRoZSBFRElEIGNvbWVzIGZyb20gdGhlIHNhbWUgZGV2aWNlIGFzIHRoZQorCSAg
cHJpbWFyeSBHT1AuIE9uIHg4NiB3aXRoIEJJT1MsIGl0IGNvbWVzIGZyb20gdGhlIFZFU0Eg
QklPUy4KKwkgIERSTSBkaXNwbGF5IGRyaXZlcnMgd2lsbCBiZSBhYmxlIHRvIGV4cG9ydCB0
aGUgaW5mb3JtYXRpb24KKwkgIHRvIHVzZXJzcGFjZS4KIAogCSAgQWxzbyBlbmFibGUgdGhp
cyBpZiBEREMvSTJDIHRyYW5zZmVycyBkbyBub3Qgd29yayBmb3IgeW91ciBkcml2ZXIKIAkg
IGFuZCBpZiB5b3UgYXJlIHVzaW5nIG52aWRpYWZiLCBpODEwZmIgb3Igc2F2YWdlZmIuCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2VmaS5oIGIvaW5jbHVkZS9saW51eC9lZmkuaApp
bmRleCAxMWUyNjc0OTJlZmQuLmVlZmY4MzkzYzljMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9lZmkuaAorKysgYi9pbmNsdWRlL2xpbnV4L2VmaS5oCkBAIC00MDYsMTEgKzQwNiwx
MyBAQCB2b2lkIGVmaV9uYXRpdmVfcnVudGltZV9zZXR1cCh2b2lkKTsKICNkZWZpbmUgRUZJ
X0NDX0ZJTkFMX0VWRU5UU19UQUJMRV9HVUlECQlFRklfR1VJRCgweGRkNGE0NjQ4LCAweDJk
ZTcsIDB4NDY2NSwgMHg5NiwgMHg0ZCwgMHgyMSwgMHhkOSwgMHhlZiwgMHg1ZiwgMHhiNCwg
MHg0NikKIAogLyoKLSAqIFRoaXMgR1VJRCBpcyB1c2VkIHRvIHBhc3MgdG8gdGhlIGtlcm5l
bCBwcm9wZXIgdGhlIHN0cnVjdCBzY3JlZW5faW5mbwotICogc3RydWN0dXJlIHRoYXQgd2Fz
IHBvcHVsYXRlZCBieSB0aGUgc3R1YiBiYXNlZCBvbiB0aGUgR09QIHByb3RvY29sIGluc3Rh
bmNlCi0gKiBhc3NvY2lhdGVkIHdpdGggQ29uT3V0CisgKiBUaGVzZSBHVUlEcyBhcmUgdXNl
ZCB0byBwYXNzIHRvIHRoZSBrZXJuZWwgcHJvcGVyIHRoZSBzdHJ1Y3Qgc2NyZWVuX2luZm8K
KyAqIGFuZCBzdHJ1Y3QgZWRpZF9pbmZvIHN0cnVjdHVyZXMgdGhhdCB3ZXJlIHBvcHVsYXRl
ZCBieSB0aGUgc3R1YiBiYXNlZCBvbgorICogdGhlIEdPUCBwcm90b2NvbCBpbnN0YW5jZSBh
c3NvY2lhdGVkIHdpdGggQ29uT3V0LgogICovCiAjZGVmaW5lIExJTlVYX0VGSV9TQ1JFRU5f
SU5GT19UQUJMRV9HVUlECUVGSV9HVUlEKDB4ZTAzZmMyMGEsIDB4ODVkYywgMHg0MDZlLCAg
MHhiOSwgMHgwZSwgMHg0YSwgMHhiNSwgMHgwMiwgMHgzNywgMHgxZCwgMHg5NSkKKyNkZWZp
bmUgTElOVVhfRUZJX0VESURfSU5GT19UQUJMRV9HVUlECQlFRklfR1VJRCgweDRlNmMxN2Vh
LCAweDZlYzAsIDB4NDgzOCwgIDB4OGMsIDB4YWUsIDB4MmMsIDB4ZjUsIDB4NGQsIDB4NWYs
IDB4NTgsIDB4NjQpCisKICNkZWZpbmUgTElOVVhfRUZJX0FSTV9DUFVfU1RBVEVfVEFCTEVf
R1VJRAlFRklfR1VJRCgweGVmNzllNGFhLCAweDNjM2QsIDB4NDk4OSwgIDB4YjksIDB4MDIs
IDB4MDcsIDB4YTksIDB4NDMsIDB4ZTUsIDB4NTAsIDB4ZDIpCiAjZGVmaW5lIExJTlVYX0VG
SV9MT0FERVJfRU5UUllfR1VJRAkJRUZJX0dVSUQoMHg0YTY3YjA4MiwgMHgwYTRjLCAweDQx
Y2YsICAweGI2LCAweGM3LCAweDQ0LCAweDBiLCAweDI5LCAweGJiLCAweDhjLCAweDRmKQog
I2RlZmluZSBMSU5VWF9FRklfUkFORE9NX1NFRURfVEFCTEVfR1VJRAlFRklfR1VJRCgweDFj
ZTFlNWJjLCAweDdjZWIsIDB4NDJmMiwgIDB4ODEsIDB4ZTUsIDB4OGEsIDB4YWQsIDB4ZjEs
IDB4ODAsIDB4ZjUsIDB4N2IpCi0tIAoyLjUxLjEKCg==

--------------r0Xzb0YoVLDjAiumVA0VLV75--

