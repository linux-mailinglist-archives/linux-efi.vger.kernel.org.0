Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA57042D5
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 03:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEPBYN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 21:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPBYM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 21:24:12 -0400
Received: from sender3-of-o57.zoho.com (sender3-of-o57.zoho.com [136.143.184.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1515258;
        Mon, 15 May 2023 18:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684200216; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RR1TfYZEGin5arrnpEvRLWCOsSlqGAODka5QOqh2UA6NN6tkN7W1/C/km7Ck+0CDl4L5rVEUMtYv+yPDiA7jNsSCKS+WP2uxKsvQC2jf61kWiBZRvWAErOIZ5SbVaixkF4lGKQqpLmeLnqHfv8cgiqYVUb1uFpAADHh84lCeVhk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684200216; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=t9xe8yTG0sKAFENcXbIvh8DJsGK2DfwwVT3xWVKVb+I=; 
        b=UiPq7TVpfHS6m6iqXIN5DewJeEvOV/dHvI8gI9eNHXYCMxTsDm/WuiYOHyCfayPhky6qGStvc3KUk3qzB7QUrxZ7ro/5tyKIGkN6PuLm3k3UMpmKfw9QQpQq2/Fc1Y7mhA8jJOSYw7FhYsmMzWRTgybRi/vuCfSZgBMCwJB8U1Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684200216;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=t9xe8yTG0sKAFENcXbIvh8DJsGK2DfwwVT3xWVKVb+I=;
        b=UChlLcFEY/XnIK0uv4PQvV3Wp/AYkCd1F/foF76++k0T6Fbsfwsl1QUco905bf8W
        YSZLMd/ydEkuFSZj1ZRHIGKTEMctK5pQzMZz4tWjqAVsVwYRWWTNNOLtnJKj2XByA59
        gWMN4d5dNI0bPS0iPIJWi8kUs/zySml0uj8qu6Ko=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1684200214907165.64041646283852; Mon, 15 May 2023 18:23:34 -0700 (PDT)
Message-ID: <0e232a30-9b47-2315-86ea-4f6eeb7829a8@apertussolutions.com>
Date:   Mon, 15 May 2023 21:23:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 11/14] reboot: Secure Launch SEXIT support on reboot
 paths
Content-Language: en-US
To:     Ross Philipson <ross.philipson@oracle.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-12-ross.philipson@oracle.com>
 <20230512114000.GG14461@srcf.ucam.org>
 <a38e0589-fa20-77ac-2fb0-2cb247c2b408@oracle.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <a38e0589-fa20-77ac-2fb0-2cb247c2b408@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/15/23 14:16, Ross Philipson wrote:
> On 5/12/23 07:40, Matthew Garrett wrote:
>> On Thu, May 04, 2023 at 02:50:20PM +0000, Ross Philipson wrote:
>>> If the MLE kernel is being powered off, rebooted or halted,
>>> then SEXIT must be called. Note that the SEXIT GETSEC leaf
>>> can only be called after a machine_shutdown() has been done on
>>> these paths. The machine_shutdown() is not called on a few paths
>>> like when poweroff action does not have a poweroff callback (into
>>> ACPI code) or when an emergency reset is done. In these cases,
>>> just the TXT registers are finalized but SEXIT is skipped.
>>
>> What are the consequences of SEXIT not being called, and why is it ok to
>> skip it in these circumstances?
> 
> Well the system is resetting so there are no real consequences. The 
> problem on those two paths is that the APs have not been halted with a 
> machine_shutdown() and that is a precondition to issuing GETSEC[SEXIT]. 
> Only the BSP should be active and SEXIT must be done on it.

To expand on this just a bit further. On all paths we were able to 
identify, the SECRETS bit is cleared, memconfig is unlocked, and the 
private registers are all closed. This makes the system as safe as 
possible to go through a power event and be able to come back up on the 
other side. The clean way is to always go through an SEXIT before a 
power event, but as Ross highlighted this can only be done after the APs 
have been halted.

v/r,
dps
