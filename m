Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD6266921
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgIKTqx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 15:46:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725849AbgIKTqw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 15:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599853611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjmdNZgB1QiAcVQQi1OwUZy+vXn3Z68cHLsliVqlB+g=;
        b=Nu3XlVqMZ7RaBiFYoW663tf0LZPapgX+gpCDV5ywA7xqb5PbY+IwyePYS9MWtahXj5UfFJ
        ZG3SYO/hHc1xY8u/8o4ajYMOsZqkawjNzq0+DNkii0C6bl/+49YZpPQoYNlPfTBxQEKLQd
        SVVD+uRj0JbXc31u4/rxEDQoAlNO1rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-iOmjCR0DMIGu14XkI0guwg-1; Fri, 11 Sep 2020 15:46:47 -0400
X-MC-Unique: iOmjCR0DMIGu14XkI0guwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5330D81F005;
        Fri, 11 Sep 2020 19:46:45 +0000 (UTC)
Received: from [10.10.110.42] (unknown [10.10.110.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7788A3782;
        Fri, 11 Sep 2020 19:46:42 +0000 (UTC)
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
 <394190b9-59bd-5cb3-317e-736852f190f4@redhat.com>
 <CAMj1kXEz8y+X6KjqWWFD=38dDowqXDBvnPbgeh30+o83KpmKrg@mail.gmail.com>
 <06ea64fec71ebd18f0c5ed6b0d9b5a7d8f1d4775.camel@linux.ibm.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <dda103c3-9a32-df8a-131e-1e8e91b92960@redhat.com>
Date:   Fri, 11 Sep 2020 15:46:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <06ea64fec71ebd18f0c5ed6b0d9b5a7d8f1d4775.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/11/20 3:08 PM, Mimi Zohar wrote:
> On Fri, 2020-09-11 at 21:16 +0300, Ard Biesheuvel wrote:
>> I think we can just merge the patches as they are, with Mimi's R-b carried over.
> 
> Other than the comments beginning on the "/*" line as opposed to the
> subsequent line, the updated 2/2 and 3/3 patches look fine.
> 
> thanks,
> 
> Mimi
> 

I also prefer the block comment style that you are suggesting. However, I
kept to the style used by the load_uefi.c source file. If checkpatch.pl
considers it acceptable, I deferred to consistency within the source module.

                       -Lenny.

