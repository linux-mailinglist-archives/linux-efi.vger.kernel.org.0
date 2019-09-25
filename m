Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752ABBE101
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfIYPQT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 11:16:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfIYPQT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Sep 2019 11:16:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 043CFC059B7A
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2019 15:16:19 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id k14so10074910iot.14
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2019 08:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WoZ3HLwN6X4dNm7Y0wAK5ji0bCw6LaTLIwuuJsi7KNE=;
        b=QiOOWTS9n/o11DExHbLQpOkk4fuT5roZhzwYs5fWoIb3aeF3jFX8WnZG2ls2stYWC0
         Y6Z8aUbSXU/Q7e3gidlMK+8kK1FQSTFO4yqg4tSNzrhHaKVYxmlUDC2x8EpUF4pQMjVS
         Gs0V/1NKc/VAv+Un+tA8EwJjhgzOn5tr15qiDN3UI8DrZ3wfsTJyOj+twrFx1B0utCA8
         yycbwAkM4AU1YocrC+e6av3Yl95rsMzT6bg/C4e+b+6/OY05RFMN6XIEiIpHxH4TvS+h
         PhVw6rGbPdA72T5pxWU0a7aHkrpHKpwPYHx7jOfdajbOvAIeVRw42+K/36nEiVzrH67j
         AxAg==
X-Gm-Message-State: APjAAAWvoTnPQOspYwCbdfn/n9SvLDHLuz0o2rlmnoBLj8ZbFWLKFAVE
        EH3+YjzM9zt2rMhazUOSPpVBx4dxFg5wglxpc+6Cx9N+4OtxySbjbARJjWHIsTngibCUCXlNh2g
        Gx7ue7bKDU0a3zO338tsW
X-Received: by 2002:a6b:b593:: with SMTP id e141mr11215318iof.233.1569424578378;
        Wed, 25 Sep 2019 08:16:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyclCyMAN4oFi2IQAAmhPq0cIxvkiB9BgZVPkpxcPaiUF3OHEyJLBDQ0SzqmUXs9Ly1ogiCAg==
X-Received: by 2002:a6b:b593:: with SMTP id e141mr11215286iof.233.1569424578099;
        Wed, 25 Sep 2019 08:16:18 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id w16sm217154ilc.62.2019.09.25.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 08:16:17 -0700 (PDT)
Date:   Wed, 25 Sep 2019 08:16:16 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190925151616.3glkehdrmuwtosn3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20190925101622.31457-1-jarkko.sakkinen@linux.intel.com>
 <CAKv+Gu9xLXWj8e70rs6Oy3aT_+qvemMJqtOETQG+7z==Nf_RcQ@mail.gmail.com>
 <20190925145011.GC23867@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190925145011.GC23867@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed Sep 25 19, Jarkko Sakkinen wrote:
>On Wed, Sep 25, 2019 at 12:25:05PM +0200, Ard Biesheuvel wrote:
>> On Wed, 25 Sep 2019 at 12:16, Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>> >
>> > From: Peter Jones <pjones@redhat.com>
>> >
>> > Some machines generate a lot of event log entries.  When we're
>> > iterating over them, the code removes the old mapping and adds a
>> > new one, so once we cross the page boundary we're unmapping the page
>> > with the count on it.  Hilarity ensues.
>> >
>> > This patch keeps the info from the header in local variables so we don't
>> > need to access that page again or keep track of if it's mapped.
>> >
>> > Fixes: 44038bc514a2 ("tpm: Abstract crypto agile event size calculations")
>> > Cc: linux-efi@vger.kernel.org
>> > Cc: linux-integrity@vger.kernel.org
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Peter Jones <pjones@redhat.com>
>> > Tested-by: Lyude Paul <lyude@redhat.com>
>> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Acked-by: Matthew Garrett <mjg59@google.com>
>> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> Thanks Jarkko.
>>
>> Shall I take these through the EFI tree?
>
>Would be great, if you could because I already sent one PR with fixes for
>v5.4-rc1 yesterday.
>
>/Jarkko

My patch collides with this, so I will submit a v3 that applies on top of
these once I've run a test with all 3 applied on this t480s.
