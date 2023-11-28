Return-Path: <linux-efi+bounces-93-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D27FB964
	for <lists+linux-efi@lfdr.de>; Tue, 28 Nov 2023 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010C61C2121F
	for <lists+linux-efi@lfdr.de>; Tue, 28 Nov 2023 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373344F5FE;
	Tue, 28 Nov 2023 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BbbKWMmm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqOvDLmL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8AAD60;
	Tue, 28 Nov 2023 03:25:30 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B0A82195A;
	Tue, 28 Nov 2023 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701170729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgMlDqCEMti1tWEV4w0pWYe9MRlT/WzXID9W1NpeXw0=;
	b=BbbKWMmmKaQrhIyb2KL6NpH9DDIGUGVP+hPGD5QCUcS6X4Hr0oBnRDuf1b3xRaZpxJitkm
	nx8r/gv7jLOAO9h8sIRcCLGDv1rhNgqWuWHGJ7ah3cxLK7G1MZtthXRtKbUzAphJfJYWCL
	27Ab0kO7Q7aTIYNxJI5IumkJ30JCpcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701170729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgMlDqCEMti1tWEV4w0pWYe9MRlT/WzXID9W1NpeXw0=;
	b=OqOvDLmLGZwIjekxgW6yZGcd83xjaN7OTKoc4Bz+CG9jrO4cHbkIF7FMgGnxkr0wQoGRZZ
	CnZbmSG5J27X0OBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F21441343E;
	Tue, 28 Nov 2023 11:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id isDDOijOZWUIAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 28 Nov 2023 11:25:28 +0000
Message-ID: <9be0159e-1762-6c07-e6eb-a86f1c780118@suse.cz>
Date: Tue, 28 Nov 2023 12:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, stable@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231103151354.110636-1-michael.roth@amd.com>
 <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
 <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.21
X-Spamd-Result: default: False [3.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.959];
	 NEURAL_SPAM_LONG(3.50)[0.999];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On 11/8/23 12:21, Ard Biesheuvel wrote:
> On Fri, 3 Nov 2023 at 16:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/3/23 16:13, Michael Roth wrote:
>> > When a task needs to accept memory it will scan the accepting_list
>> > to see if any ranges already being processed by other tasks overlap
>> > with its range. Due to an off-by-one in the range comparisons, a task
>> > might falsely determine that an overlapping range is being accepted,
>> > leading to an unnecessary delay before it begins processing the range.
>> >
>> > Fix the off-by-one in the range comparison to prevent this and slightly
>> > improve performance.
>> >
>> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
>> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
>> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>>
>> More justification for introducing a common ranges_overlap() helper somewhere :)
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
> 
> Thanks, I'll take this as a fix.

Ping, can't see it in mainline nor -next?

> 
>> > ---
>> > v2:
>> >  * Improve commit message terminology (Kirill)
>> > ---
>> >  drivers/firmware/efi/unaccepted_memory.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
>> > index 135278ddaf62..79fb687bb90f 100644
>> > --- a/drivers/firmware/efi/unaccepted_memory.c
>> > +++ b/drivers/firmware/efi/unaccepted_memory.c
>> > @@ -100,7 +100,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>> >        * overlap on physical address level.
>> >        */
>> >       list_for_each_entry(entry, &accepting_list, list) {
>> > -             if (entry->end < range.start)
>> > +             if (entry->end <= range.start)
>> >                       continue;
>> >               if (entry->start >= range.end)
>> >                       continue;
>>
> 


