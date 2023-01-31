Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA456829C8
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjAaKAk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 05:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjAaKAi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 05:00:38 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38494ABE9;
        Tue, 31 Jan 2023 02:00:32 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id B0E6740D403D;
        Tue, 31 Jan 2023 10:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B0E6740D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675159228;
        bh=h4ToMGMZFYqFycLaLNJ4vdum98eO1aybaTxkVOuGkJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g+JYm/fhlp78oZKB6Obj0kKsvhCD2k5Pk34fdePNw5FOwbxZb3ZibZogOGlDCaHO6
         thAjOlXB9Esnt71jyGox8o+YIwX0R92HzAk4fgpPXSyThH8FOvByk11E4VbDVGW+HE
         +Bo1s4+zzdEvuYUfE2jXcSRFKfs1jZO9F2cmI23k=
MIME-Version: 1.0
Date:   Tue, 31 Jan 2023 13:00:28 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 22/24] efi/libstub: Add memory attribute protocol
 definitions
In-Reply-To: <CAMj1kXF5tE+vj_Kf_z=KTqoi12PBq5g5Ds+097w9ge+U4NQong@mail.gmail.com>
References: <cover.1668958803.git.baskov@ispras.ru>
 <44539c8c6afdba66f791942deae95c7b13d1e13b.1668958803.git.baskov@ispras.ru>
 <CAMj1kXF5tE+vj_Kf_z=KTqoi12PBq5g5Ds+097w9ge+U4NQong@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c3dcdf14c51adfa7558eeaec4378287e@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-01-31 11:37, Ard Biesheuvel wrote:
> On Tue, 22 Nov 2022 at 12:14, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> EFI_MEMORY_ATTRIBUTE_PROTOCOL servers as a better alternative to
>> DXE services for setting memory attributes in EFI Boot Services
>> environment. This protocol is better since it is a part of UEFI
>> specification itself and not UEFI PI specification like DXE
>> services.
>> 
>> Add EFI_MEMORY_ATTRIBUTE_PROTOCOL definitions.
>> Support mixed mode properly for its calls.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> 
> I have fixed up just this patch, as there is another user for the
> protocol in zboot.
> 

One patch less in the patch set then, thanks!
