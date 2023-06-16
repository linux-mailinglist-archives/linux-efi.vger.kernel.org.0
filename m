Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475F1733659
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jun 2023 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjFPQpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jun 2023 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjFPQpY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jun 2023 12:45:24 -0400
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206092D5D;
        Fri, 16 Jun 2023 09:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686933873; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K2OqRJfe2GJeQkgK+NEfGjq73mCcLWdnFodkO4sXrmbaizIXLgu/HsyvpE4MNNgewC3PfqZc9YurYjtjUtpFwePrVKK/iuvjr6v+Juj5UNR0kZ+OyQzlYBclaXTR02bROnRL5QOsjEc3rULeLFL4rcL14f35RIjIQC0oQz/H5xg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686933873; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YFf4KgEPbWL7mvIIGoCh2dt81HyAXm/q6dL8q62QUqM=; 
        b=kb9ONZdR3/WmMIh5NKTpkxb+0Jep9fQsD3Bvuhu7PXPgr+bmFTj7c0BpiAI8u0q+/CqrM9xchX3nosSThjR4vxl6hK+jOAMdlblqBaxbEl5VXL7ZtKqLvI/hV4K5g/KJfyApi2Qc6j+gtX9i9BG2priSe99Pqii8Iz34p0k8YEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686933873;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=YFf4KgEPbWL7mvIIGoCh2dt81HyAXm/q6dL8q62QUqM=;
        b=Zmm4hQ+1IB3Tmr3ET8PdXzI6pVC5ayUXdkDP6CGRW1kSJ6DFF7YlFkZ79uWonUGq
        TAW8ZH1SzLEIAN52IyqhxVDi7IKcNCnpgsJYk+ciL7/T37ppygDLq0bCbIGxIQYa8FL
        9koCYVDg8mzvMx2f1pm8JHdr/FiOBV9ex0qFx/YM=
Received: from [10.10.1.133] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1686933870911516.0622407770464; Fri, 16 Jun 2023 09:44:30 -0700 (PDT)
Message-ID: <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
Date:   Fri, 16 Jun 2023 12:44:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <20230512104753.GA14461@srcf.ucam.org>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <20230512104753.GA14461@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 5/12/23 06:47, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
>> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
>> +built with KASLR disabled::
> 
> Why does Secure Launch not interoperate with KASLR?
> 
> Re: IOMMUs

Until the IOMMU driver comes online, memory is protected by the PMRs 
regions requested by the Preamble (pre-launch code) in accordance with 
Intel TXT specifications and configured by the ACM. The KASLR randomizer 
will run before the IOMMU driver is able to come online and ensure 
frames used by the kernel are protected as well as frames that a driver 
may registered in a BAR are not blocked.

>> +It is recommended that no other command line options should be set to override
>> +the defaults above.
> 
> What happens if they are? Does doing so change the security posture of
> the system? If so, will the measurements be different in a way that
> demonstrates the system is in an insecure state?
> 

In an early version of the patch series this was enforced when turning 
on Secure Launch, but concerns were raised over this approach and was 
asked to allow the user to be able to shoot themselves in the foot. 
Overriding these values could render either an insecure state and/or an 
unstable system.
