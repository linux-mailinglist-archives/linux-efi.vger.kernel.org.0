Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81C2DD248
	for <lists+linux-efi@lfdr.de>; Thu, 17 Dec 2020 14:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgLQNkf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Dec 2020 08:40:35 -0500
Received: from www74.your-server.de ([213.133.104.74]:58906 "EHLO
        www74.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgLQNkf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Dec 2020 08:40:35 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www74.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1kptVT-000FAb-Bh; Thu, 17 Dec 2020 14:39:47 +0100
Received: from [95.91.111.52] (helo=[192.168.178.21])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1kptVT-0008Cg-5K; Thu, 17 Dec 2020 14:39:47 +0100
Subject: Re: Efistub patch breaks 5.10 for me
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Limonciello, Mario" <mario.limonciello@dell.com>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <242ea718-89f8-e74f-e48a-e6b0fa436ed1@computerix.info>
 <CAMj1kXHSSZftuv-M9Gg-V+XFTJtFtii8Jfqin03kstSuF9DRJA@mail.gmail.com>
From:   Klaus Kusche <klaus.kusche@computerix.info>
Message-ID: <21bee914-35d0-c33d-b68c-20574f8e6fb6@computerix.info>
Date:   Thu, 17 Dec 2020 14:39:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHSSZftuv-M9Gg-V+XFTJtFtii8Jfqin03kstSuF9DRJA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: klaus.kusche@computerix.info
X-Virus-Scanned: Clear (ClamAV 0.102.4/26019/Wed Dec 16 15:36:02 2020)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hello,

On 17/12/2020 13:41, Ard Biesheuvel wrote:
>> tried to boot 5.10.1 (my first attempt to boot a 5.10.x).
>>
>> Displays
>>
>> EFI stub: WARNING: [Firmware Bug]: LoadOptions is an EFI_LOAD_OPTION descriptor
>> EFI stub: WARNING: [Firmware Bug]: Using OptionalData as a workaround
>>
>> for one or two seconds on the notebook display.
>>
>> Then, the notebook display becomes completely black
>> and the notebook does not boot and does not react to anything
>> (hard poweroff needed).
> 
> Hello Klaus,
> 
> Please try reverting
> 
> 4a568ce29d3f48df95919f82a80e4b9be7ea0dc1
> 
> "efi/x86: Add a quirk to support command line arguments on Dell EFI firmware"

Thanks for the quick response.

Efistub is *not* the culprit:

With the patch reverted, the two efistub error messages are gone.
And with the two errormessages not occupying the display and my attention,
I noticed that the kernel actually came up for fractions of a second
before the display went dark.

AMD radeon seems to be the culprit: 
After unconfiguring it, the system comes up fine in text mode,
both with and without the efistub patch.

And with the efistub patch applied, 
dmesg actually shows an empty command line instead of the \x01,
as it should.

-- 
Prof. Dr. Klaus Kusche
Private address: Rosenberg 41, 07546 Gera, Germany
+49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
+49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
