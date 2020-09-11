Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147CE2665F2
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIKRSp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 13:18:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726253AbgIKRSn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 13:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599844722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUZ4F9VBNeDOexQ4ImvdIONeNb+COlnwiJ6I4shsy2Q=;
        b=DGBcsiVIS5SppKeGM+tEZFuL5BHWVlALpjMKWHiZnsjVWQ4sA6bTXRU+HbI2vwgmYHYEOe
        cJXBj7x937T83oNsa5Pfhn+AEQ22LVP1cf5+MeACXBm2YUMHbOIKFf+tvc6fZvgZQFoVt7
        IornEuy67lOKWNw83aVUfxsQO1SIc6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Yrhrg5z2Nv6BretARpwOBA-1; Fri, 11 Sep 2020 13:18:38 -0400
X-MC-Unique: Yrhrg5z2Nv6BretARpwOBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67899393B6;
        Fri, 11 Sep 2020 17:18:36 +0000 (UTC)
Received: from [10.10.110.42] (unknown [10.10.110.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477E45C1BD;
        Fri, 11 Sep 2020 17:18:33 +0000 (UTC)
Subject: Re: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a
 separate routine
To:     Mimi Zohar <zohar@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-3-lszubowi@redhat.com>
 <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
 <f0a079b1-5f02-8618-fdfe-aea2278113c9@redhat.com>
 <cb8b4ebaa35d79eba65b011d042d20a991adf540.camel@linux.ibm.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <394190b9-59bd-5cb3-317e-736852f190f4@redhat.com>
Date:   Fri, 11 Sep 2020 13:18:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cb8b4ebaa35d79eba65b011d042d20a991adf540.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/11/20 11:59 AM, Mimi Zohar wrote:
> On Fri, 2020-09-11 at 11:54 -0400, Lenny Szubowicz wrote:
>> On 9/11/20 11:02 AM, Ard Biesheuvel wrote:
>>> On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>>>>
>>>> Move the loading of certs from the UEFI MokListRT into a separate
>>>> routine to facilitate additional MokList functionality.
>>>>
>>>> There is no visible functional change as a result of this patch.
>>>> Although the UEFI dbx certs are now loaded before the MokList certs,
>>>> they are loaded onto different key rings. So the order of the keys
>>>> on their respective key rings is the same.
>>>>
>>>> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
>>>
>>> Why did you drop Mimi's reviewed-by from this patch?
>>
>> It was not intentional. I was just not aware that I needed to propagate
>> Mimi Zohar's reviewed-by from V1 of the patch to V2.
>>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>
>> V2 includes changes in that patch to incorporate suggestions from
>> Andy Shevchenko. My assumption was that the maintainer would
>> gather up the reviewed-by and add any signed-off-by as appropriate,
>> but it sounds like my assumption was incorrect. In retrospect, I
>> could see that having the maintainer dig through prior versions
>> of a patch set for prior reviewed-by tags could be burdensome.
> 
> As much as possible moving code should be done without making changes,
> simpler for code review.   Then as a separate patch you make changes.
> That way you could also have retained my Reviewed-by.
> 
> Mimi

If you or Ard think I should, I can do a V3 with:

   Patch V3 01: Unchanged from V2
   Patch V3 02: Goes back to V1 of patch 02 that Mimi reviewed
   Patch V3 03: New. Has Andy's cleanup suggestions separated from patch 02
   Patch V3 04: This would most probably just be the V2 of patch 03 with no changes

                  -Lenny.

> 
>>
>> Advice on the expected handling of this would be appreciated.
> 
> 

