Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F386F8682
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjEEQTK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEEQTJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 12:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90217FE2;
        Fri,  5 May 2023 09:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4845263F15;
        Fri,  5 May 2023 16:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDE1C433EF;
        Fri,  5 May 2023 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683303547;
        bh=9eVD8TLEEJTPz7yUDaY/tcM4ySNHmYkUZSsW6auAYhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loLHgZ6lqZrIKBgo3yKKid4OzVFYz+8ZiKK82DAcPHoYWv38JEZTzJBc/0Jilf3Ac
         13ZT853kkIOz5s92U2aLs8Qsw3/pa5XZXTWrM7RLBw1djPdirH/b7e328JT1KQDfo5
         Ia02U9yr3HawpR+b0VyOH8cI2VeNJrHrSxmbVFpT3yoROBJG7kA8FvP3nIX4blUvei
         1+YXY4yq6kvmuJAt1kUewv/TelPNq3i/P251E+XOAquYRG4fANOUEKMcFwQTJW2bcf
         3FEbGZUddqObaXNkWfTnpVbHzIE26/z88HVTnkB5sY9x/JYwY+Z5S7f7VIT7tH5VvM
         nkytUGk7g4Aow==
Date:   Fri, 5 May 2023 18:19:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <ZFUsdbkulMLlU3XA@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> Introduce background, overview and configuration/ABI information
> for the Secure Launch kernel feature.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Hi Ross and Daniel,

some minor nits from my side.

> ---
>  Documentation/security/index.rst                   |   1 +
>  Documentation/security/launch-integrity/index.rst  |  10 +
>  .../security/launch-integrity/principles.rst       | 313 ++++++++++++
>  .../launch-integrity/secure_launch_details.rst     | 564 +++++++++++++++++++++
>  .../launch-integrity/secure_launch_overview.rst    | 220 ++++++++
>  5 files changed, 1108 insertions(+)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/principles.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
> 
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 6ed8d2f..fade37e 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -18,3 +18,4 @@ Security Documentation
>     digsig
>     landlock
>     secrets/index
> +   launch-integrity/index
> diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
> new file mode 100644
> index 0000000..28eed91d
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/index.rst
> @@ -0,0 +1,10 @@

I believe an SPDX tag should go at the top of each .rst file.

> +=====================================
> +System Launch Integrity documentation
> +=====================================
> +
> +.. toctree::
> +
> +   principles
> +   secure_launch_overview
> +   secure_launch_details
> +
> diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
> new file mode 100644
> index 0000000..73cf063
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/principles.rst
> @@ -0,0 +1,313 @@
> +=======================
> +System Launch Integrity
> +=======================
> +
> +This document serves to establish a common understanding of what is system
> +launch, the integrity concern for system launch, and why using a Root of Trust
> +(RoT) from a Dynamic Launch may be desired. Through out this document
> +terminology from the Trusted Computing Group (TCG) and National Institue for

s/Institue/Institute/

...

> +Trust Chains
> +============
> +
> +Bulding upon the understanding of security mechanisms to establish load-time

s/Bulding/Building/

...

> diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst

...

> +Secure Launch Resource Table
> +============================
> +
> +The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard format
> +for providing information for the pre-launch environment and to pass
> +information to the post-launch environment. The table is populated by one or
> +more bootloaders in the boot chain and used by Secure Launch on how to setup
> +the environment during post-launch. The details for the SLRT are documented
> +in the TrenchBoot Secure Launch Specifcation [3]_.

s/Specifcation/Specification/

...
