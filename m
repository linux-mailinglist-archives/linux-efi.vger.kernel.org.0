Return-Path: <linux-efi+bounces-1745-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090E97858C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD11228B3BF
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633436AFAE;
	Fri, 13 Sep 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E2Lun5z6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qc+RtkFk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E2Lun5z6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qc+RtkFk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A518D502
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244091; cv=none; b=Zip/isILT5vnEp1CKP0hGKDJIZechu+3qgx0akvHQWQ78gmPtZ3f29K2Z3vchyFjCKsYOJcxubCpQpjzSW3bMlHNzHKpUeTzsJmz8vNL0ybHTjJxuWBBpJSrQX/qbjNeontTTPFDOkbDSfbEodP6L6d7Zk9WMyAirrKomKZ+wXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244091; c=relaxed/simple;
	bh=ohNklpXWOzSi8oRuq+vrsqLSiDjYp5zqf4QII4GWBzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpXzl4kOIu27m8IpPCYqW4rdGLx6UgCW6palZivbNZkTKvSek45F+HBhGkQcvNgRBAmZBDxF32H+sec2MpBeVZg7r2qyP2fQBV0CfL6BJ/ohbY/bvFsMTxxIZXWm9WqICIfjXqJTBeIROOSoxZzgkTje/XPLWlLdj9X6+ct2GWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E2Lun5z6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qc+RtkFk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E2Lun5z6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qc+RtkFk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B086D1F385;
	Fri, 13 Sep 2024 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726244087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mrBeYJV+4chn9B3QqvucR1/leZJAsrR0TSkzzerEj/Q=;
	b=E2Lun5z6ke9/jxNEFAEz2MnkNwLck2E3i4iPLnyiytMvdL4Idu3j8ToTW8wvlcUZTlXv4p
	ttYfD+rIyo+V6PsxeMjHzqc3jUm2hJBG92GNV44cLpoiBMPUyWT+YaoXZQaDjk+6DxNmV7
	Aag1fHnkNWYGQW4a9uqfjDaIXIXLdWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726244087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mrBeYJV+4chn9B3QqvucR1/leZJAsrR0TSkzzerEj/Q=;
	b=qc+RtkFkC6xnXfmbM9m7RiR/uLSuQGVha7r56ShcRwphyxMsueMAYaGOlJhSHRs7UqE9DC
	ibnMgKva9YeEJIDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E2Lun5z6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qc+RtkFk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726244087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mrBeYJV+4chn9B3QqvucR1/leZJAsrR0TSkzzerEj/Q=;
	b=E2Lun5z6ke9/jxNEFAEz2MnkNwLck2E3i4iPLnyiytMvdL4Idu3j8ToTW8wvlcUZTlXv4p
	ttYfD+rIyo+V6PsxeMjHzqc3jUm2hJBG92GNV44cLpoiBMPUyWT+YaoXZQaDjk+6DxNmV7
	Aag1fHnkNWYGQW4a9uqfjDaIXIXLdWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726244087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mrBeYJV+4chn9B3QqvucR1/leZJAsrR0TSkzzerEj/Q=;
	b=qc+RtkFkC6xnXfmbM9m7RiR/uLSuQGVha7r56ShcRwphyxMsueMAYaGOlJhSHRs7UqE9DC
	ibnMgKva9YeEJIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8530A13A73;
	Fri, 13 Sep 2024 16:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C98vH/dk5GZzWwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 13 Sep 2024 16:14:47 +0000
Message-ID: <12349d45-1e88-4363-a2a2-e84304e04f25@suse.de>
Date: Fri, 13 Sep 2024 18:14:46 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No more /sys/bus/platform/drivers/efi-framebuffer since
 simpledrm?
To: Ard Biesheuvel <ardb@kernel.org>, Richard Hughes <richard@hughsie.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "jk@ozlabs.org" <jk@ozlabs.org>
References: <b6Fl9paVpZ66bxYu2jwpQPAIcEZ6UzY2iGUGKd7GSdr9dBRhvK1aLYUG-FWbVdT7YoV-x53b4kleO-krBFTrzKVDdLiCHlVsvVxGgG_cW64=@hughsie.com>
 <CAMj1kXEaigChABCMrUAnkxFrEQq=Np9Zbo+CU+LdMrzu9mjYmQ@mail.gmail.com>
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
In-Reply-To: <CAMj1kXEaigChABCMrUAnkxFrEQq=Np9Zbo+CU+LdMrzu9mjYmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B086D1F385
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

(cc'ing Javier)

Am 13.09.24 um 15:53 schrieb Ard Biesheuvel:
> Hi Richard,
>
> On Thu, 5 Sept 2024 at 11:22, Richard Hughes <richard@hughsie.com> wrote:
>> Hi all,
>>
>> The fwupd daemon used to read /sys/bus/platform/drivers/efi-framebuffer to get the EFI framebuffer size so we can choose the UX capsule bitmap for the correct size (and set the correct position) -- and make the UEFI firmware update for users a little nicer.
>>
>> We've found out that that API has disappeared without warning in Fedora 40. Seemingly the only way to get the info now is to scrape the kernel event log -- but that can't be the right way to do it? I also don't think we can use the DRI interface as we don't know what card/crt the firmware used for booting.
>>
>> We pondered if this was a regression from the conversion from efifb to simpledrm. I'm using a standard Fedora 40 distro kernel, with the config of https://people.freedesktop.org/~hughsient/temp/config-6.10.6-200.fc40.x86_64 if that helps. Any advice most welcome.
>>
> cc'ing Thomas, who was involved in this work.

I think that is the issue that has been discussed (and maybe resolved) at

   https://github.com/fwupd/fwupd/issues/7598

Best regards
Thomas



-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


