Return-Path: <linux-efi+bounces-5679-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D7C83B11
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 08:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26B8B34248B
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FF32D0C97;
	Tue, 25 Nov 2025 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUdO/WfD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dl8Ok7ik";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUdO/WfD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dl8Ok7ik"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC8284894
	for <linux-efi@vger.kernel.org>; Tue, 25 Nov 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055197; cv=none; b=kse7CLDrqL7I6h5XmMJbZtodQX1HJerPX7FUmGXGLZknjQLia9yN7G8Jl1dNmlIiZUnCZHtxkiNi6dj4uchVfTqAiLjPIfJC29gxnxNhQsYdorQgXVll5XorbnxnQdJdauokE0xyf3wLOlglLwxTxOkwIkSf/UlV/q3HuKx+8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055197; c=relaxed/simple;
	bh=dLQBG1rEQ7d1Hra5TlsDFEOOTNry8QeKbqugR4oFGPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wb6SMK1d6KJExxLfO34BhUWjmNnD0Cf+GBNW1o0/U3iB6hfTge4ny6WbWi+1TTT2au2lBJ3HYrEtaeX3WOQiYFc7fqA4SbtLWYdo0tpNs6hw4rpFhWkc6hRR4QY2yOazvkVzlutFFRxsCaC9XJwChK88hQU8/I5xWTsEyZSCZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUdO/WfD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dl8Ok7ik; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUdO/WfD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dl8Ok7ik; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99FA922653;
	Tue, 25 Nov 2025 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764055193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TPntlOqdFWfhwr/Kbhykec41hobmmKyQB3TzxwFkUv4=;
	b=WUdO/WfD173ZFq/tfqsxWjrcSCfzNOy7tCuCaHuzEzYTyMWLfWbSib+W6SkFD1tRLlwL/q
	DwpKjQoEkV9VRf3QULw259l6zaM7JVcR8IAq395MIcXM75BJY7k0P2uefrI5y2ffhOsh6Z
	sE6cnd7fyct7T3tkXKZJnYk4rUZ0pjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764055193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TPntlOqdFWfhwr/Kbhykec41hobmmKyQB3TzxwFkUv4=;
	b=dl8Ok7ikIupkgbJXbm1AVIfcq/9jM7IhiDaGX+BG12s20Hlm7OY4gJHWiPARPiIZOS2wnd
	GrZUz0T1bdH7R3AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764055193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TPntlOqdFWfhwr/Kbhykec41hobmmKyQB3TzxwFkUv4=;
	b=WUdO/WfD173ZFq/tfqsxWjrcSCfzNOy7tCuCaHuzEzYTyMWLfWbSib+W6SkFD1tRLlwL/q
	DwpKjQoEkV9VRf3QULw259l6zaM7JVcR8IAq395MIcXM75BJY7k0P2uefrI5y2ffhOsh6Z
	sE6cnd7fyct7T3tkXKZJnYk4rUZ0pjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764055193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TPntlOqdFWfhwr/Kbhykec41hobmmKyQB3TzxwFkUv4=;
	b=dl8Ok7ikIupkgbJXbm1AVIfcq/9jM7IhiDaGX+BG12s20Hlm7OY4gJHWiPARPiIZOS2wnd
	GrZUz0T1bdH7R3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2035F3EA63;
	Tue, 25 Nov 2025 07:19:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ynIsBplYJWn5QQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Nov 2025 07:19:53 +0000
Message-ID: <8ff77586-724e-48a4-9282-643e8fa84d96@suse.de>
Date: Tue, 25 Nov 2025 08:19:52 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] efi: Support EDID information
To: Ard Biesheuvel <ardb@kernel.org>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20251124165116.502813-1-tzimmermann@suse.de>
 <20251124165116.502813-9-tzimmermann@suse.de>
 <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
 <CAMj1kXFtsneE3dFgUx6Hd=iBhD8YpvjfTSi-KZpuNaXfX07KyA@mail.gmail.com>
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
In-Reply-To: <CAMj1kXFtsneE3dFgUx6Hd=iBhD8YpvjfTSi-KZpuNaXfX07KyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 24.11.25 um 18:04 schrieb Ard Biesheuvel:
> On Mon, 24 Nov 2025 at 18:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Mon, 24 Nov 2025 at 17:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Add LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID to the list of config-table
>>> UUIDs. Read sysfb_primary_display from the entry. The UUID has been
>>> generated with uuidgen.
>>>
>>> Still support LINUX_EFI_SCREEN_INFO_TABLE_GUID as fallback in case an
>>> older boot loader invokes the kernel.
>>>
>>> If CONFIG_FIRMWARE_EDID=n, EDID information is disabled.
>>>
>>> Make the Kconfig symbol CONFIG_FIRMWARE_EDID available with EFI. Setting
>>> the value to 'n' disables EDID support.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Why are we adding a new config table again?
>>
>>
> Note that LINUX_EFI_SCREEN_INFO_TABLE_GUID is internal ABI only
> between the EFI stub and the core kernel.

Ah, ok. That's my misconception. I was thinking that we have to support 
external boot loaders building a config table.

I'll just extend the existing UUID then.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



