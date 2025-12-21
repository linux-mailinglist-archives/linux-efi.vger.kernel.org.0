Return-Path: <linux-efi+bounces-5912-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57903CD42DF
	for <lists+linux-efi@lfdr.de>; Sun, 21 Dec 2025 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E76300C5EA
	for <lists+linux-efi@lfdr.de>; Sun, 21 Dec 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A6223DE7;
	Sun, 21 Dec 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mCnt4Y8g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+fysO4lT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SK/TpTNu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JK9Vnvs5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48C1487E9
	for <linux-efi@vger.kernel.org>; Sun, 21 Dec 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333918; cv=none; b=Z1QPW0XZdTT8WPclu0IypQURr91ociKX2A/DagpSO+CSDgkUhbQo4FaqBnhUhgTmO5CrL6WDJF26ScCSt/h+AC5A9vS0WHCfyoJArNYDaaif/COnXoAPD/V7tTpaR71HGrptl8uU6Nsvoag9LRexFBfMv+h2t+RMpd20blHfTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333918; c=relaxed/simple;
	bh=b6N6Jj7QBC5KdMoc+yYcrtzg/8owWwq3DmZcwg0Z8v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOTqERgDBERjMVG4+RWYYALh4ZBLhJqrLDSyHH8yiv/ubqZ93WFldVDbC0fhU6SutSsxdMtefxCVxTNWWs7rkWPIg8N6taawSpGMef58p8rLZ5XtCOH1PWtEUIgP3HF/n/gBF+Sw5uOcM/YatPmTYXOyhOcyFoU8ZvjRPCVEfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mCnt4Y8g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+fysO4lT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SK/TpTNu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JK9Vnvs5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 653C35BCC2;
	Sun, 21 Dec 2025 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766333910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Yj5PCkcX3NpOx0MVubHGjm/vyE75Or7OKm5HcbRRAM=;
	b=mCnt4Y8g9wsGeC8a71YqMV35vOzr1m0HM69UW17UulhUuwVG0ydF3uuvzeXLa4GIvslZ7S
	QYQc3/3AA/mLmpp+EtuVSWHSFyj2qHFq13+nY3F0Sz2QLUSg458KpQloTphi22MZ5Meq/4
	GIRIQkIUdIRy7RQxjyXcgjxIfnpljRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766333910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Yj5PCkcX3NpOx0MVubHGjm/vyE75Or7OKm5HcbRRAM=;
	b=+fysO4lT9QRvCJD4KFhF25SM1m1m/VNA80U1DScLwbWpQQYgUEyHmTeDGtG7rBrqQV+M1F
	6h3OrRzIQ6Ob+kBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SK/TpTNu";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JK9Vnvs5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766333909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Yj5PCkcX3NpOx0MVubHGjm/vyE75Or7OKm5HcbRRAM=;
	b=SK/TpTNuD9iwQ9XXcNlTwGcmiWFxH31bYOz2qi35e3x4fDRgAsvNA+ZhUzRPxq2nzxPFHF
	RvhyFdO8JkbXaUmVNgZ58vW8x0HCHKwcOGRGsaidcJfg1bVOfg3aVOEyZwSXTlFJXdYsPb
	LNIrSYQRjUUWwcmwLqIn/6OIXHPU5xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766333909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Yj5PCkcX3NpOx0MVubHGjm/vyE75Or7OKm5HcbRRAM=;
	b=JK9Vnvs5Ps/AD+vFcl47c3Ac/ds9F0AXi/mGl57Rxm+IAa4aNyMKLohCuHyatBPjX+BmXa
	jJVUd9ZB1w6TZPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B7513A54;
	Sun, 21 Dec 2025 16:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oHBlN9QdSGnANgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Sun, 21 Dec 2025 16:18:28 +0000
Message-ID: <0204b4f2-98b3-4463-9ae7-fc3657ce2fc1@suse.de>
Date: Sun, 21 Dec 2025 17:18:28 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] efi: libstub: Simplify interfaces for
 primary_display
To: Ard Biesheuvel <ardb@kernel.org>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com,
 helgaas@kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20251126160854.553077-1-tzimmermann@suse.de>
 <20251126160854.553077-10-tzimmermann@suse.de>
 <CAMj1kXFeBS7O5A-CPds3UfFnjegGTpVsuF7VznBc-zZ+gjygtw@mail.gmail.com>
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
In-Reply-To: <CAMj1kXFeBS7O5A-CPds3UfFnjegGTpVsuF7VznBc-zZ+gjygtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 653C35BCC2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Hi

Am 16.12.25 um 14:23 schrieb Ard Biesheuvel:
> Hi Thomas
>
> On Wed, 26 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Rename alloc_primary_display() and __alloc_primary_display(), clarify
>> free semantics to make interfaces easier to understand.
>>
>> Rename alloc_primary_display() to lookup_primary_display() as it
>> does not necessarily allocate. Then rename __alloc_primary_display()
>> to the new alloc_primary_display(). The helper belongs to
>> free_primary_display), so it should be named without underscores.
>>
>> The lookup helper does not necessarily allocate, so the output
>> parameter needs_free to indicate when free should be called.
> I don't understand why we need this. Whether or not the helper
> allocates is a compile time decision, and in builds where it doesn't,
> the free helper doesn't do anything.
>
> I'm all for making things simpler, but I don't think this patch
> achieves that tbh.
>
> I've queued up this series now up until this patch - once we converge
> on the simplification, I'm happy to apply it on top.

If you don't want this patch, just leave it out then. Coming from 
another subsystem, I found the current logic and naming confusing THB.

Best regards
Thomas


>
> Thanks,
>
>
>
>> Pass
>> an argument through the calls to track this state. Put the free
>> handling into release_primary_display() for simplificy.
>>
>> Also move the comment fro primary_display.c to efi-stub-entry.c,
>> where it now describes lookup_primary_display().
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/firmware/efi/libstub/efi-stub-entry.c | 23 +++++++++++++++++--
>>   drivers/firmware/efi/libstub/efi-stub.c       | 22 ++++++++++++------
>>   drivers/firmware/efi/libstub/efistub.h        |  2 +-
>>   .../firmware/efi/libstub/primary_display.c    | 17 +-------------
>>   drivers/firmware/efi/libstub/zboot.c          |  6 +++--
>>   5 files changed, 42 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
>> index aa85e910fe59..3077b51fe0b2 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
>> @@ -14,10 +14,29 @@ static void *kernel_image_addr(void *addr)
>>          return addr + kernel_image_offset;
>>   }
>>
>> -struct sysfb_display_info *alloc_primary_display(void)
>> +/*
>> + * There are two ways of populating the core kernel's sysfb_primary_display
>> + * via the stub:
>> + *
>> + *   - using a configuration table, which relies on the EFI init code to
>> + *     locate the table and copy the contents; or
>> + *
>> + *   - by linking directly to the core kernel's copy of the global symbol.
>> + *
>> + * The latter is preferred because it makes the EFIFB earlycon available very
>> + * early, but it only works if the EFI stub is part of the core kernel image
>> + * itself. The zboot decompressor can only use the configuration table
>> + * approach.
>> + */
>> +
>> +struct sysfb_display_info *lookup_primary_display(bool *needs_free)
>>   {
>> +       *needs_free = true;
>> +
>>          if (IS_ENABLED(CONFIG_ARM))
>> -               return __alloc_primary_display();
>> +               return alloc_primary_display();
>> +
>> +       *needs_free = false;
>>
>>          if (IS_ENABLED(CONFIG_X86) ||
>>              IS_ENABLED(CONFIG_EFI_EARLYCON) ||
>> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
>> index 42d6073bcd06..dc545f62c62b 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub.c
>> @@ -51,14 +51,14 @@ static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
>>   void __weak free_primary_display(struct sysfb_display_info *dpy)
>>   { }
>>
>> -static struct sysfb_display_info *setup_primary_display(void)
>> +static struct sysfb_display_info *setup_primary_display(bool *dpy_needs_free)
>>   {
>>          struct sysfb_display_info *dpy;
>>          struct screen_info *screen = NULL;
>>          struct edid_info *edid = NULL;
>>          efi_status_t status;
>>
>> -       dpy = alloc_primary_display();
>> +       dpy = lookup_primary_display(dpy_needs_free);
>>          if (!dpy)
>>                  return NULL;
>>          screen = &dpy->screen;
>> @@ -68,15 +68,22 @@ static struct sysfb_display_info *setup_primary_display(void)
>>
>>          status = efi_setup_graphics(screen, edid);
>>          if (status != EFI_SUCCESS)
>> -               goto err_free_primary_display;
>> +               goto err___free_primary_display;
>>
>>          return dpy;
>>
>> -err_free_primary_display:
>> -       free_primary_display(dpy);
>> +err___free_primary_display:
>> +       if (*dpy_needs_free)
>> +               free_primary_display(dpy);
>>          return NULL;
>>   }
>>
>> +static void release_primary_display(struct sysfb_display_info *dpy, bool dpy_needs_free)
>> +{
>> +       if (dpy && dpy_needs_free)
>> +               free_primary_display(dpy);
>> +}
>> +
>>   static void install_memreserve_table(void)
>>   {
>>          struct linux_efi_memreserve *rsv;
>> @@ -156,13 +163,14 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>>                               char *cmdline_ptr)
>>   {
>>          struct sysfb_display_info *dpy;
>> +       bool dpy_needs_free;
>>          efi_status_t status;
>>
>>          status = check_platform_features();
>>          if (status != EFI_SUCCESS)
>>                  return status;
>>
>> -       dpy = setup_primary_display();
>> +       dpy = setup_primary_display(&dpy_needs_free);
>>
>>          efi_retrieve_eventlog();
>>
>> @@ -182,7 +190,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>>
>>          status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
>>
>> -       free_primary_display(dpy);
>> +       release_primary_display(dpy, dpy_needs_free);
>>
>>          return status;
>>   }
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index 979a21818cc1..1503ffb82903 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -1176,8 +1176,8 @@ efi_enable_reset_attack_mitigation(void) { }
>>
>>   void efi_retrieve_eventlog(void);
>>
>> +struct sysfb_display_info *lookup_primary_display(bool *needs_free);
>>   struct sysfb_display_info *alloc_primary_display(void);
>> -struct sysfb_display_info *__alloc_primary_display(void);
>>   void free_primary_display(struct sysfb_display_info *dpy);
>>
>>   void efi_cache_sync_image(unsigned long image_base,
>> diff --git a/drivers/firmware/efi/libstub/primary_display.c b/drivers/firmware/efi/libstub/primary_display.c
>> index cdaebab26514..34c54ac1e02a 100644
>> --- a/drivers/firmware/efi/libstub/primary_display.c
>> +++ b/drivers/firmware/efi/libstub/primary_display.c
>> @@ -7,24 +7,9 @@
>>
>>   #include "efistub.h"
>>
>> -/*
>> - * There are two ways of populating the core kernel's sysfb_primary_display
>> - * via the stub:
>> - *
>> - *   - using a configuration table, which relies on the EFI init code to
>> - *     locate the table and copy the contents; or
>> - *
>> - *   - by linking directly to the core kernel's copy of the global symbol.
>> - *
>> - * The latter is preferred because it makes the EFIFB earlycon available very
>> - * early, but it only works if the EFI stub is part of the core kernel image
>> - * itself. The zboot decompressor can only use the configuration table
>> - * approach.
>> - */
>> -
>>   static efi_guid_t primary_display_guid = LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID;
>>
>> -struct sysfb_display_info *__alloc_primary_display(void)
>> +struct sysfb_display_info *alloc_primary_display(void)
>>   {
>>          struct sysfb_display_info *dpy;
>>          efi_status_t status;
>> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
>> index 4b76f74c56da..c1fd1fdbcb08 100644
>> --- a/drivers/firmware/efi/libstub/zboot.c
>> +++ b/drivers/firmware/efi/libstub/zboot.c
>> @@ -26,9 +26,11 @@ void __weak efi_cache_sync_image(unsigned long image_base,
>>          // executable code loaded into memory to be safe for execution.
>>   }
>>
>> -struct sysfb_display_info *alloc_primary_display(void)
>> +struct sysfb_display_info *lookup_primary_display(bool *needs_free)
>>   {
>> -       return __alloc_primary_display();
>> +       *needs_free = true;
>> +
>> +       return alloc_primary_display();
>>   }
>>
>>   asmlinkage efi_status_t __efiapi
>> --
>> 2.51.1
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



