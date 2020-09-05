Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8725E4E3
	for <lists+linux-efi@lfdr.de>; Sat,  5 Sep 2020 03:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgIEBat (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 21:30:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57319 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgIEBas (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 21:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599269446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SbbgKalcr5xmssml+g6cMxSIZlFM2ReWbmS6BC9CpM=;
        b=NcPialkJ8r5vnvqaAIwVRR8fsbZe48boM7DlgY7cAlZbnNuQo4s51B4zTaJ01x/1etqtBt
        nnC3qmuU4NzWkmzrLIZ2qDUGB7AOBi68/wB2Dt0P36E1hlHLiORvBvgo10SuJuuKdc8rdv
        Wj/O2wKeIHVHfqfZoU3q4+5b9QYd5zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-a4drdPbVNVCRdiCkc0cVOw-1; Fri, 04 Sep 2020 21:30:43 -0400
X-MC-Unique: a4drdPbVNVCRdiCkc0cVOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A608F802B72;
        Sat,  5 Sep 2020 01:30:40 +0000 (UTC)
Received: from [10.10.65.66] (ovpn-65-66.rdu2.redhat.com [10.10.65.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296127EED7;
        Sat,  5 Sep 2020 01:30:39 +0000 (UTC)
Subject: Re: [PATCH 0/3] integrity: Load certs from EFI MOK config table
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        bp@alien8.de, pjones@redhat.com, dhowells@redhat.com,
        prarit@redhat.com
References: <20200826034455.28707-1-lszubowi@redhat.com>
 <6f63a0cf1349281ef2c407d95abedfba1f90345a.camel@linux.ibm.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <1e4d1f97-e1c1-d76d-1f91-135290da625c@redhat.com>
Date:   Fri, 4 Sep 2020 21:30:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6f63a0cf1349281ef2c407d95abedfba1f90345a.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/26/20 7:55 AM, Mimi Zohar wrote:
> Hi Lenny,
> 
> On Tue, 2020-08-25 at 23:44 -0400, Lenny Szubowicz wrote:
>> Because of system-specific EFI firmware limitations,
>> EFI volatile variables may not be capable of holding the
>> required contents of the Machine Owner Key (MOK) certificate
>> store. Therefore, an EFI boot loader may pass the MOK certs
>> via a EFI configuration table created specifically for this
>> purpose to avoid this firmware limitation.
>>
>> An EFI configuration table is a simpler and more robust mechanism
>> compared to EFI variables and is well suited for one-way passage
>> of static information from a pre-OS environment to the kernel.
>>
>> This patch set does not remove the support for loading certs
>> from the EFI MOK variables into the platform key ring.
>> However, if both the EFI MOK config table and corresponding
>> EFI MOK variables are present, the MOK table is used as the
>> source of MOK certs.
>>
>> The contents of the individual named MOK config table entries are
>> made available to user space via read-only sysfs binary files under:
>>
>> 	/sys/firmware/efi/mok-variables/
> 
> Please include a security section in this cover letter with a
> comparison of the MoK variables and the EFI configuration table
> security (eg. same mechanism?).  Has mokutil been updated?  If so,
> please provide a link.
> 
> Mimi
> 

I've included some more information about the MOK config table
entries in the V2 cover letter.

[root@localhost ~]# ls -l /sys/firmware/efi/mok-variables
total 0
-r--------. 1 root root     0 Sep  4 21:10 MokIgnoreDB
-r--------. 1 root root 18184 Sep  4 21:10 MokListRT
-r--------. 1 root root    76 Sep  4 21:10 MokListXRT
-r--------. 1 root root     0 Sep  4 21:10 MokSBStateRT

The roughly 18KB of data in /sys/firmware/efi/mok-variables/MokListRT
is exactly the same data that is returned by a EFI GetVariable()
call for MokListRT. Of course, that's on a system where the EFI
firmware can handle a volatile variable with that much data.

Therefore, load_moklist_certs() can pass the mokvar_entry data directly
to parse_efi_signature_list() in the same way it does for the
efi.get_variable() data that it obtains via get_cert_list().

Unfortunately, there is no updated mokutil available yet that
uses the new sysfs entries.

Also relevant is availability of an updated shim, which builds
the EFI MOK variable configuration table.

Of course, both of these should show up as upstream pull requests
and also in Fedora rawhide at some point.

Thank you for your review.

                       -Lenny.



