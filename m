Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8604A6245F7
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJPcb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiKJPcO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 10:32:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1122D42F50;
        Thu, 10 Nov 2022 07:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1502619B2;
        Thu, 10 Nov 2022 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117F5C4314A;
        Thu, 10 Nov 2022 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668094233;
        bh=LxPoey/Txw9eEAsjMi8I7lrIBlKYQ+GUi78jSLCLmsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X/8MmAQ4jzybDO0FM4EnvciY0o909vg7RORFRkthrlYFTQH/hYSUJP5KQ1UHS/aAh
         5IjLCETD67uMhtSRZPFAWhe6aHAyo5cCjvFNv1P2q0PHs2Q7d6S9iAAdpDrsUdcsqg
         6GE4uuSR3MxU07c0Oom2uDFZnxIvRDhEWaudlGfodGtTvdoXJC5xtPi+eTiquIgsVz
         ja9QmMQiB7KHHw+psH3Je1bjKqnjze0b/XA4JsOTYT5U2blBIdMcQuxIS/yPN9K1bM
         mzlQYs4u7edJlck0qSDrGzy+L18yAqVVPredbYqD0kSvVnSQe+qXksx3hdrExzeDRH
         xdDUVZCZzAwdw==
Received: by mail-lf1-f48.google.com with SMTP id c1so3934549lfi.7;
        Thu, 10 Nov 2022 07:30:32 -0800 (PST)
X-Gm-Message-State: ACrzQf15eZ9rnkAcSCeYQTGlyG8npzDDZyZJb+lSOYbqBlj5f3NrEpaz
        wVYETrxgBQ5neAvZ1OmSU69H4IEEtJnQVAyHE8I=
X-Google-Smtp-Source: AMsMyM4zvAX5sAETC9CI+cDlc2ACByQOg0lFOlzCPS65eEG++tMrkP/vj9NOXHY5hJrb5BSfltNUuM/SQvrZljQqoJc=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr20875682lfk.426.1668094230829; Thu, 10
 Nov 2022 07:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com> <20221110000129.kl6pjy5mafpuptbk@framework>
 <4A479B96-4B41-4323-9920-5A909423F998@oracle.com> <20221110150607.h4iaymkgc4f7kuue@framework>
 <47ae05f8d3a67ee5e1607ab8e718cc4b3e95cebb.camel@HansenPartnership.com>
In-Reply-To: <47ae05f8d3a67ee5e1607ab8e718cc4b3e95cebb.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Nov 2022 16:30:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEv3raFtwMmA4gYX=Z5YBfJ5f9GP0L0Zo4FBabwTfhn8Q@mail.gmail.com>
Message-ID: <CAMj1kXEv3raFtwMmA4gYX=Z5YBfJ5f9GP0L0Zo4FBabwTfhn8Q@mail.gmail.com>
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT found
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Morten Linderud <morten@linderud.pw>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Nov 2022 at 16:27, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2022-11-10 at 16:06 +0100, Morten Linderud wrote:
> > I'm not really sure what Peter means with "much more reliable"
> > though.
>
> It's that in-head knowledge you referred to.  You can't see the true
> MoK variables because they're BootServices, meaning they're not visible
> in the RunTime, which is why the shadow RT variables exist (this is a
> security property: BS only variables can only be altered by trusted,
> signed entities).  However lots of things can create RT variables so
> you have to run through a sequence of checks on the RT shadows to try
> to defeat clever attackers (like verifying the variable attributes),
> because the chain of custody from BS to RT is not guaranteed.  If you
> use a configuration table instead, that is BS only, the kernel (which
> is also a trusted entity) has to pick it out before ExitBootServices,
> so if the kernel has the table, you have a reliable chain of custody
> for the entries.
>

No config table are always accessible, also at runtime under the OS.

But they are volatile so they can only have been created since the
last reset of the system, so in that sense they are similar to the
volatile RT variables aliases.

The reason for preferring config tables is that you can access them
much earlier, and without mapping the EFI runtime memory regions etc
etc
