Return-Path: <linux-efi+bounces-2904-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD79A55FCB
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 06:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67BF3AAA0A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9537148FF9;
	Fri,  7 Mar 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz9AmOC/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014F29408;
	Fri,  7 Mar 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741324246; cv=none; b=YT7tRSko+i1NVimVGHrUWBsMdy6xVTNM+mNxS9pFAHdCryYHMXFBpIMxYig5Xh3M0UYvLbFDEWP+grNjdwl4pAo44i1dg5O5EZd68X0A8e4p2/2+5JwGjMJQJiQnc67gSic70AmL8Yf9v75YdsD0+mZmjYBu7ZTH/uOopHWmJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741324246; c=relaxed/simple;
	bh=VcUVlFIitotGE0i9+kH0vpVYTvtPQGTwCoxsoWlqZYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYIXWlT38ID/QPaZuqEF0n83zxyLlIGdKxLZMoN4PYcwXobKz/+VbMBCg/4PwZ7oSv639QwjR4cqhIzVn0R+YGigGQ7Giy/t0PySpak8alsaOyjMtZZy5LVJqaFyf4eyddXmA+bbXl/MYiuyNLYkPXTSd6q9SOTjG2yOME3lWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz9AmOC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39949C4CEE3;
	Fri,  7 Mar 2025 05:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741324246;
	bh=VcUVlFIitotGE0i9+kH0vpVYTvtPQGTwCoxsoWlqZYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz9AmOC/0FvKvhT31zFnCJzvgv0W8jNaph+1VbsfE4p27+b2BCgpTwevfLQRxGAw9
	 faosXIp5bn0xPabPqe093AbqpIp/j9AyBM/EozwEMMDEZuuDs2MWhQVJ6IYvMk2lLs
	 uETJ5RJ5paej3TvE8rdDWh66LyE+3yMbEJP5DdJVCtOv5i4ZUqLiLRdJ405rx1mbyU
	 aqyC7wigemvLP/Rta/5U46UQMi3HyoneaRc5N2S/4ytLxgK0cTs1bokaayy5vOMoPH
	 v0uXkw/mPxlHdS62MW/sJ/LqIG9ONM/tBfopTal0KiWM+7LP/bbM6W2HBtU1FRbOnu
	 5ZKwutMSQpEtw==
Date: Fri, 7 Mar 2025 07:10:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 01/19] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <Z8p_0UfZ3ByzmPfK@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-2-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-2-ross.philipson@oracle.com>

 On Thu, Dec 19, 2024 at 11:41:58AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Introduce background, overview and configuration/ABI information
> for the Secure Launch kernel feature.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/security/index.rst              |   1 +
>  .../security/launch-integrity/index.rst       |  11 +
>  .../security/launch-integrity/principles.rst  | 317 ++++++++++
>  .../secure_launch_details.rst                 | 587 ++++++++++++++++++
>  .../secure_launch_overview.rst                | 252 ++++++++
>  5 files changed, 1168 insertions(+)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/principles.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
> 
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 3e0a7114a862..f89741271ed0 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -20,3 +20,4 @@ Security Documentation
>     landlock
>     secrets/index
>     ipe
> +   launch-integrity/index
> diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
> new file mode 100644
> index 000000000000..838328186dd2
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/index.rst
> @@ -0,0 +1,11 @@
> +=====================================
> +System Launch Integrity documentation
> +=====================================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   principles
> +   secure_launch_overview
> +   secure_launch_details
> +
> diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
> new file mode 100644
> index 000000000000..a0553d1d93c2
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/principles.rst
> @@ -0,0 +1,317 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2019-2024 Daniel P. Smith <dpsmith@apertussolutions.com>
> +
> +=======================
> +System Launch Integrity
> +=======================
> +
> +:Author: Daniel P. Smith
> +:Date: August 2024
> +
> +This document serves to establish a common understanding of what a system
> +launch is, the integrity concern for system launch, and why using a Root of Trust
> +(RoT) from a Dynamic Launch may be desirable. Throughout this document,
> +terminology from the Trusted Computing Group (TCG) and National Institute for
> +Standards and Technology (NIST) is used to ensure that vendor natural language is
> +used to describe and reference security-related concepts.
> +
> +System Launch
> +=============
> +
> +There is a tendency to only consider the classical power-on boot as the only
> +means to launch an Operating System (OS) on a computer system. In fact, most
> +modern processors support two system launch methods. To provide clarity,
> +it is important to establish a common definition of a system launch: during
> +a single power life cycle of a system, a system launch consists of an initialization
> +event, typically in hardware, that is followed by an executing software payload
> +that takes the system from the initialized state to a running state. Driven by
> +the Trusted Computing Group (TCG) architecture, modern processors are able to
> +support two methods of system launch. These two methods of system launch are known
> +as Static Launch and Dynamic Launch.
> +
> +Static Launch
> +-------------
> +
> +Static launch is the system launch associated with the power cycle of the CPU.
> +Thus, static launch refers to the classical power-on boot where the
> +initialization event is the release of the CPU from reset and the system
> +firmware is the software payload that brings the system up to a running state.
> +Since static launch is the system launch associated with the beginning of the
> +power lifecycle of a system, it is therefore a fixed, one-time system launch.
> +It is because of this that static launch is referred to and thought of as being
> +"static".
> +
> +Dynamic Launch
> +--------------
> +
> +Modern CPUs architectures provides a mechanism to re-initialize the system to a
> +"known good" state without requiring a power event. This re-initialization
> +event is the event for a dynamic launch and is referred to as the Dynamic
> +Launch Event (DLE). The DLE functions by accepting a software payload, referred
> +to as the Dynamic Configuration Environment (DCE), that execution is handed to
> +after the DLE is invoked. The DCE is responsible for bringing the system back
> +to a running state. Since the dynamic launch is not tied to a power event like
> +the static launch, this enables a dynamic launch to be initiated at any time
> +and multiple times during a single power life cycle. This dynamism is the
> +reasoning behind referring to this system launch as "dynamic".
> +
> +Because a dynamic launch can be conducted at any time during a single power
> +life cycle, they are classified into one of two types: an early launch or a
> +late launch.
> +
> +:Early Launch: When a dynamic launch is used as a transition from a static
> +   launch chain to the final Operating System.
> +
> +:Late Launch: The usage of a dynamic launch by an executing Operating System to
> +   transition to a "known good" state to perform one or more operations, e.g. to
> +   launch into a new Operating System.
> +
> +System Integrity
> +================
> +
> +A computer system can be considered a collection of mechanisms that work
> +together to produce a result. The assurance that the mechanisms are functioning
> +correctly and producing the expected result is the integrity of the system. To
> +ensure a system's integrity, there is a subset of these mechanisms, commonly
> +referred to as security mechanisms, that is present to help ensure the system
> +produces the expected result or at least detects the potential of an unexpected
> +result. Since the security mechanisms are relied upon to ensue the integrity of
> +the system, these mechanisms are trusted. Upon inspection, these security
> +mechanisms each have a set of properties and these properties can be evaluated
> +to determine how susceptible a mechanism might be to failure. This assessment is
> +referred to as the Strength of Mechanism, which allows the trustworthiness of
> +that mechanism to be quantified.
> +
> +For software systems, there are two system states for which the integrity is
> +critical: when the software is loaded into memory and when the software is
> +executing on the hardware. Ensuring that the expected software is loaded into
> +memory is referred to as load-time integrity while ensuring that the software
> +executing is the expected software is the runtime integrity of that software.

I'd consider deleting the first paragraph. It really does not provide
anything useful. The 2nd paragraph is totally sufficient introduction to
the topic, and makes factors more sense.

We don't need a phrase in kernel documentation stating that computer is
a system that produces a result :-)

Should be at least easy enough change to make. I don't think it even
needs any refined version as the text below provides more than enough
(in many places useful) detail to the topic.

> +
> +Load-time Integrity
> +-------------------
> +
> +It is critical to understand what load-time integrity establishes about a
> +system and what is assumed, i.e. what is being trusted. Load-time integrity is

I'd delete the very first sentence completely. It serves zero purpose.
This would be so much less exhausting read if I could just start on
getting the information what load-time integrity is.

Reassurance serves zero purpose. It is up to the read of kernel
documentation to make such evaluation.

> +when a trusted entity, i.e. an entity with an assumed integrity, takes an
> +action to assess an entity being loaded into memory before it is used. A
> +variety of mechanisms may be used to conduct the assessment, each with
> +different properties. A particular property is whether the mechanism creates an
> +evidence of the assessment. Often either cryptographic signature checking or
> +hashing are the common assessment operations used.
> +
> +A signature checking assessment functions by requiring a representation of the
> +accepted authorities and uses those representations to assess if the entity has
> +been signed by an accepted authority. The benefit to this process is that
> +assessment process includes an adjudication of the assessment. The drawbacks
> +are that 1) the adjudication is susceptible to tampering by the Trusted
> +Computing Base (TCB), 2) there is no evidence to assert that an untampered
> +adjudication was completed, and 3) the system must be an active participant in
> +the key management infrastructure.
> +
> +A cryptographic hashing assessment does not adjudicate the assessment, but

This is actually language barrier: is "cryptographic hashing assesment"
same as "cryptographic measurement"? I'd consider using latter as it has
wider reach. Most people know what measurement means if they know any of
cryptography.

> +instead generates evidence of the assessment to be adjudicated independently.
> +The benefits to this approach is that the assessment may be simple such that it
> +may be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
> +it is possible for the adjudication to be conducted where it cannot be tampered
> +with by the TCB. The drawback is that a compromised environment will be allowed
> +to execute until an adjudication can be completed.
> +
> +Ultimately, load-time integrity provides confidence that the correct entity was
> +loaded and in the absence of a run-time integrity mechanism assumes, i.e.
> +trusts, that the entity will never become corrupted.
> +
> +Runtime Integrity
> +-----------------
> +
> +Runtime integrity in the general sense is when a trusted entity makes an
> +assessment of an entity at any point in time during the assessed entity's
> +execution. A more concrete explanation is the taking of an integrity assessment

Great, this is better than the last subsection as it gets straight into
the topic! No reassurance part ;-)

> +of an active process executing on the system at any point during the process'
> +execution. Often the load-time integrity of an operating system's user-space,
> +i.e. the operating environment, is confused with the runtime integrity of the
> +system, since it is an integrity assessment of the "runtime" software. The
> +reality is that actual runtime integrity is a very difficult problem and thus
> +not very many solutions are public and/or available. One example of a runtime
> +integrity solution would be Johns Hopkins Advanced Physics Laboratory's (APL)
> +Linux Kernel Integrity Module (LKIM).
> +
> +Trust Chains
> +============
> +
> +Building upon the understanding of security mechanisms to establish load-time
> +integrity of an entity, it is possible to chain together load-time integrity
> +assessments to establish the integrity of the whole system. This process is
> +known as transitive trust and provides the concept of building a chain of
> +load-time integrity assessments, commonly referred to as a trust chain. These
> +assessments may be used to adjudicate the load-time integrity of the whole
> +system. This trust chain is started by a trusted entity that does the first
> +assessment. This first entity is referred to as the Root of Trust(RoT) with the
> +entities name being derived from the mechanism used for the assessment, i.e.
> +RoT for Verification (RTV) and RoT for Measurement (RTM).
> +
> +A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
> +and therefore it also has a Strength of Mechanism. The factors that contribute
> +to the strength of a trust chain are:
> +
> +  - The strength of the chain's RoT
> +  - The strength of each member of the trust chain
> +  - The length, i.e. the number of members, of the chain
> +
> +Therefore, the strongest trust chains should start with a strong RoT and should
> +consist of members being of low complexity and minimize the number of members
> +participating. In a more colloquial sense, a trust chain is only as strong as its
> +weakest link, thus more links increase the probability of a weak link.
> +
> +Dynamic Launch Components
> +=========================
> +
> +The TCG architecture for dynamic launch is composed of a component series
> +used to set up and then carry out the launch. These components work together to
> +construct an RTM trust chain that is rooted in the dynamic launch and thus commonly
> +referred to as the Dynamic Root of Trust for Measurement (DRTM) chain.
> +
> +What follows is a brief explanation of each component in execution order. A
> +subset of these components are what establishes the dynamic launch's trust
> +chain.
> +
> +Dynamic Configuration Environment Preamble
> +------------------------------------------
> +
> +The Dynamic Configuration Environment (DCE) Preamble is responsible for setting
> +up the system environment in preparation for a dynamic launch. The DCE Preamble
> +is not a part of the DRTM trust chain.
> +
> +Dynamic Launch Event
> +--------------------
> +
> +The dynamic launch event is the event, typically a CPU instruction, that
> +triggers the system's dynamic launch mechanism to begin the launch process. The
> +dynamic launch mechanism is also the RoT for the DRTM trust chain.
> +
> +Dynamic Configuration Environment
> +---------------------------------
> +
> +The dynamic launch mechanism may have resulted in a reset of a portion of the
> +system. To bring the system back to an adequate state for system software, the
> +dynamic launch will hand over control to the DCE. Prior to handing over this
> +control, the dynamic launch will measure the DCE. Once the DCE is complete, it
> +will proceed to measure and then execute the Dynamic Launch Measured
> +Environment (DLME).
> +
> +Dynamic Launch Measured Environment
> +-----------------------------------
> +
> +The DLME is the first system kernel to have control of the system, but may not
> +be the last. Depending on the usage and configuration, the DLME may be the
> +final/target operating system, or it may be a bootloader that will load the
> +final/target operating system.
> +
> +Why DRTM
> +========

Nit: maybe 

Why DTRM?
=========


> +
> +It is a fact that DRTM increases the load-time integrity of the system by
> +providing a trust chain that has an immutable hardware RoT, uses a limited
> +number of small, special purpose code to establish the trust chain that starts
> +the target operating system. As mentioned in the Trust Chain section, these are
> +the main three factors in driving up the strength of a trust chain. As has been
> +seen with the BootHole exploit, which in fact did not affect the integrity of
> +DRTM solutions, the sophistication of attacks targeting system launch is at an
> +all-time high. There is no reason a system should not employ every available
> +hardware integrity measure. This is the crux of a defense-in-depth
> +approach to system security. In the past, the now closed SMI gap was often
> +pointed to as invalidating DRTM, which in fact was nothing but a straw man
> +argument. As has continued to be demonstrated, if/when SMM is corrupted, it can
> +always circumvent all load-time integrity (SRTM and DRTM) because it is a
> +run-time integrity problem. Regardless, Intel and AMD have both deployed
> +runtime integrity for SMI and SMM which is tied directly to DRTM such that this
> +perceived deficiency is now non-existent and the world is moving forward with
> +an expectation that DRTM must be present.

Here's my general feeling about text up to this point. It's way too
verbose and has bad reach especially for non-native speakers.

I don't want nitpick every possible sentence that I think could be
made for punctual.

What I'd suggest instead would be to go through this internalla at
Oracle with some group of people couple of times and try to cut out
all the extra fat.

I gave those review comments in order to give an idea what kind of
stuff look up for. The benefit is that if you get this document more
readable that also as a side-effect lowers the barrier to review the
patch series. Right now this is more exhausting to read than some of
the actualy science papers I've read.

Hope no one takes this personally. What comes after this is much better
fit but I'd still do similar assessment.

Roughly estimated you could have a document 50% of the current length
without loss of information content just by being a factor more
punctual. I'm worried that the series gets ignored partly because
the documentation is already like climbing to a mountain.

BR, Jarkko

 

